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
        }
    });