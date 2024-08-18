# Welcome to Cloud Functions for Firebase for Python!
# To get started, simply uncomment the below code or create your own.
# Deploy with `firebase deploy`

import flask
import google.cloud.firestore
# The Firebase Admin SDK to access Cloud Firestore.
from firebase_admin import auth, firestore, initialize_app
# The Cloud Functions for Firebase SDK to create Cloud Functions and set up triggers.
from firebase_functions import firestore_fn, https_fn, options, scheduler_fn

default_app = initialize_app()

# Initialize
app = flask.Flask(__name__)

@app.route("/buymeacoffee_webhook", methods=["POST"])
def buymeacoffee_webhook():
    #* Buy Me A Coffee 후원 정보를 받아 Firebase DB에 저장
    try:
        data = flask.request.get_json()  
    except Exception as e:
        print(f"Error parsing JSON data: {e}")
        return "JSON parsing error", 400
    webhook_type = data.get("type") 
    print('webhook_type: ',webhook_type)

    if webhook_type == "donation.created":
        save_donation_to_firestore(data)
    elif webhook_type == "extra_purchase.created":
        save_extra_purchase_to_firestore(data)
    else:
        print(f"Unsupported webhook type: {webhook_type}")
        return "Unsupported webhook type", 400 

    return "Success", 200

def save_donation_to_firestore(data):
    """Saves donation information to Firestore, handling various data structures.

    Args:
        data (dict): The donation data in JSON format.

    Returns:
        None
    """

    # Extract donation details from the provided data, handling potential variations
    try:
        donation_info = {
            "amount": data["data"].get("amount"),
            "currency": data["data"].get("currency"),
            "supporter_name": data["data"]["supporter_name"],
            "support_type": data["data"]["support_type"],
            "created_at": data["data"].get("created_at"),
            "message": data["data"]["message"],  # Optional message field
            "coffee_count": data["data"]["coffee_count"],  # Optional coffee count
            "coffee_price": data["data"]["coffee_price"],  # Optional coffee price
            "transaction_id": data["data"]["transaction_id"],  # Optional transaction ID
            "application_fee": data["data"]["application_fee"],  # Optional application fee
            "supporter_id": data["data"]["supporter_id"],  # Optional supporter ID
            "supporter_email": data["data"]["supporter_email"],  # Optional supporter email
            "total_amount_charged": data["data"].get("total_amount_charged"),  # Optional total charged
        }
    except KeyError as e:
        print(f"Error: Missing key in donation data: {e}")
        return

    # Connect to Firestore (assuming proper configuration)
    firestore_client = firestore.client()  # Replace with your Firestore client initialization

    # Save donation information to Firestore
    try:
        firestore_client.collection("donations").add(donation_info)
        print("Donation information saved successfully to Firestore!")
    except Exception as e:
        print(f"Error saving donation to Firestore: {e}")
        
   
def save_extra_purchase_to_firestore(data):
    """Saves extra purchase information to Firestore.

    Args:
        data (dict): The extra purchase data in JSON format.

    Returns:
        None
    """

    # Extract purchase details, handling potential variations in JSON structure
    try:
        first_extra = data["data"]["extras"][0]  # Assuming at least one extra exists

        purchase_info = {
            "extra_title": first_extra["title"],
            "extra_amount": first_extra.get("amount"),
            "quantity": first_extra["quantity"],  # Handle optional quantity
            "description": first_extra["description"],  # Handle optional description
            "supporter_name": data["data"]["supporter_name"],
            "support_type": data["data"]["support_type"],
            "created_at": data["data"].get("created_at"),
            "message": data["data"]["message"],  # Optional message field
            "transaction_id": data["data"]["transaction_id"],  # Optional transaction ID
            "application_fee": data["data"]["application_fee"],  # Optional application fee
            "supporter_id": data["data"]["supporter_id"],  # Optional supporter ID
            "supporter_email": data["data"]["supporter_email"],  # Optional supporter email
            "total_amount_charged": data["data"].get("total_amount_charged"),  # Optional total charged
        }
    except (KeyError, IndexError) as e:
        print(f"Error: Missing data in extra purchase: {e}")
        return

    # Connect to Firestore (assuming proper configuration)
    firestore_client = firestore.client()  # Replace with your Firestore client initialization

    # Save purchase information to Firestore
    try:
        firestore_client.collection("purchases").add(purchase_info)
        incrementCount = purchase_info['quantity'] * 10
        firestore_client.collection("statistics").document('records').update({"remainingFaceReadings": firestore.Increment(incrementCount)})
        print("Purchase information saved successfully to Firestore!")
    except Exception as e:
        print(f"Error saving Purchase to Firestore: {e}")


@https_fn.on_request(
        cors=options.CorsOptions(
            cors_origins="*",
            cors_methods=["get", "post"])
)
def https_flask(req: https_fn.Request) -> https_fn.Response:
    with app.request_context(req.environ):
        return app.full_dispatch_request()


# Run once a day at midnight, to clean up inactive users.
# Manually run the task here https://console.cloud.google.com/cloudscheduler

# @scheduler_fn.on_schedule(schedule="* * * * *") # 1분마다 실행
@scheduler_fn.on_schedule(schedule="0 * * * *") # 1시간마다 실행
def chargeRemainingFaceReadingCount(event: scheduler_fn.ScheduledEvent) -> None:
    try:
        firestore_client = firestore.client()
        doc_ref = firestore_client.collection("statistics").document('records')
        records = doc_ref.get().to_dict()
        remainingFaceReadings = records['remainingFaceReadings']
        if(remainingFaceReadings < 10):
            doc_ref.update({"remainingFaceReadings": 10})
    except Exception as e:
        print(f"Error Charge remainingFaceReadings to Firestore: {e}")
