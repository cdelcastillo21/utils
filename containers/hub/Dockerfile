FROM jupyterhub/jupyterhub:1.2

# Copy JupyterHub configuration into container
COPY jupyterhub_config.py .

RUN pip install dockerspawner

RUN adduser carlos
RUN echo carlos:12345 | chpasswd
