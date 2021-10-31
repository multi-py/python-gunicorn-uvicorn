## How To
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


### Multistage Example

In this example we use a multistage build to compile our libraries in one container and then move them into the container we plan on using. This creates small containers while avoiding the frustration of installing build tools in a piecemeal way.

```dockerfile
FROM ghcr.io/{{ organization  }}/{{ short_repository }}:py{{ python_versions|last }}-{{ package_versions|last }}

# Build any packages in the bigger container with all the build tools
COPY requirements /requirements
RUN pip install --no-cache-dir -r /requirements


FROM ghcr.io/{{ organization  }}/{{ short_repository }}:py{{ python_versions|last }}-slim-{{ package_versions|last }}

# Copy the compiled python libraries from the first stage
COPY --from=0 /usr/local/lib/python3.9 /usr/local/lib/python3.9

COPY ./app app
```


### PreStart Script

When the container is launched it will run the script at `/app/prestart.sh` before starting the uvicorn service. This is an ideal place to put things like database migrations.

