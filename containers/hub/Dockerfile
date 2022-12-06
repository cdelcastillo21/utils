FROM jupyterhub/jupyterhub

# Copy JupyterHub configuration into container
COPY jupyterhub_config.py .

RUN pip install dockerspawner

RUN adduser carlos 
RUN echo carlos:foo | chpasswd
