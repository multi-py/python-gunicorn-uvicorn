ARG python_version=3.9
ARG publish_target=$python_version
ARG package_version
FROM python:ghcr.io/multi-py/python-gunicorn:py$publish_target-LATEST

# Add args to container scope.
ARG publish_target
ARG python_version
ARG package
ARG package_version
ARG maintainer=""
ARG TARGETPLATFORM=""
LABEL python=$python_version
LABEL package=$package
LABEL maintainer=$maintainer
LABEL org.opencontainers.image.description="python:$publish_target $package:$package_version $TARGETPLATFORM"


COPY --from=ghcr.io/multi-py/python-uvicorn:py$publish_target-$package_version /usr/local/lib/python${$python_version}/site-packages/* /usr/local/lib/python${$python_version}/site-packages/

# Startup Script
COPY ./assets/start.sh /start.sh
RUN chmod +x /start.sh

# Example application so container "works" when run directly.
COPY ./assets/main.py /app/main.py
WORKDIR /app/

ENV PYTHONPATH=/app

CMD ["/start.sh"]
