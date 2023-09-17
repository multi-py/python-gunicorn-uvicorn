## Environmental Variables

### `PORT`

The port that the application inside of the container will listen on. This is different from the host port that gets mapped to the container.


### `WORKERS`

The number of workers to launch. A good starting point is 4 processes per core (defaults to 4).


### `LOG_LEVEL`

The uvicorn log level. Must be one of the following:

* `critical`
* `error`
* `warning`
* `info`
* `debug`
* `trace`


### `MODULE_NAME`

The python module that uvicorn will import. This value is used to generate the APP_MODULE value.


### `VARIABLE_NAME`

The python variable containing the ASGI application inside of the module that uvicorn imports. This value is used to generate the APP_MODULE value.


### `APP_MODULE`

The python module and variable that is passed to uvicorn. When used the `VARIABLE_NAME` and `MODULE_NAME` environmental variables are ignored.


### `PRE_START_PATH`

Where to find the prestart script.


### `RELOAD`

When this is set to the string `true` uvicorn is launched in reload mode. If any files change uvicorn will reload the modules again, allowing for quick debugging. This comes at a performance cost, however, and should not be enabled on production machines.

### `GUNICORN_EXTRA_FLAGS`

This variable can be used to pass extra flags to the `gunicorn` command on launch. It's value is added directly to the command that is called, and has to be formatted appropriately for the command line.


### `UVICORN_EXTRA_FLAGS`

This variable can be used to pass extra flags to the `uvicorn` command on launch. It's value is added directly to the command that is called, and has to be formatted appropriately for the command line.

