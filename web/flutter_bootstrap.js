    /**
    * This function creates a delay of 500 milliseconds.
    *
    * @returns {Promise} A Promise that resolves after the delay.
    */
    function addDelay() {
        return new Promise((resolve) => setTimeout(resolve, 500));
    }

    {{flutter_js}}
    {{flutter_build_config}}

    // Load the Flutter engine
    _flutter.loader.load({
        onEntrypointLoaded: async function (engineInitializer) {
            // Initialize the Flutter engine.
            await engineInitializer.initializeEngine({ useColorEmoji: true })
            .then(function(appRunner) {
            document.getElementById('anim_loading').style.display = 'none';
            appRunner.runApp();
            });;
            // // Add a delay before running the app to create a smooth crossfade effect.
            // await addDelay();
    
            // // Run the Flutter app.
            // await appRunner.runApp();
    
            // Add a fade-in effect to the Flutter view element.
            document.querySelector("flutter-view").classList.add("fade-in");
        }
    });