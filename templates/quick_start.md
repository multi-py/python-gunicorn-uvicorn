{% set short_repository = repository.split("/")[1] -%}

### Add Your App

By default the startup script checks for the following packages and uses the first one it can find-

* `/app/app/main.py`
* `/app/main.py`

If you are using pip to install dependencies your dockerfile could look like this-

```dockerfile
FROM ghcr.io/{{ organization  }}/{{ short_repository }}:py{{ python_versions|last }}-{{ package_versions|last }}

COPY requirements /requirements
RUN pip install --no-cache-dir -r /requirements
COPY ./app app
```


### PreStart Script

When the container is launched it will run the script at `/app/prestart.sh` before starting the uvicorn service. This is an ideal place to put things like database migrations.
