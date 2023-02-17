import os
import sys
from pathlib import Path
import dockerspawner


c = get_config()


class DockerSpawner(dockerspawner.DockerSpawner):
    def create_object(self):
        self.extra_create_kwargs["ports"] = {
            "%i/tcp" % self.port: None,
            "%i/tcp" % 8225: None,
        }
        self.extra_host_config["port_bindings"] = {
            self.port: (self.host_ip,),
            8225: (self.host_ip,),
        }
        self.extra_host_config["port_bindings"] = {
            self.port: (self.host_ip,),
            8225: (self.host_ip,),
        }
        return super().create_object()


notebook_dir = os.environ.get('DOCKER_NOTEBOOK_DIR') or '/home/jovyan/work'

c.DockerSpawner.default_url = '/lab'
c.DockerSpawner.network_name = os.environ['DOCKER_NETWORK_NAME']
c.DockerSpawner.notebook_dir = notebook_dir
c.DockerSpawner.volumes = {'jupyterhub-user-carlos': notebook_dir,
                           '/home/carlos/data': {'bind': '/home/shared/'},
                           '/media/carlos/DataDrive/data': {'bind': '/home/data-drive/'}}
c.DockerSpawner.allowed_images = {'minimal': 'clos21/jlab',
                                  'adcirc': 'clos21/jlab-adcirc',
                                  'tensorflow': 'clos21/jlab-tf',
                                  'tensorflow-adcirc': 'clos21/jlab-adcirc'}
c.DockerSpawner.container_ip = "0.0.0.0"
# c.DockerSpawner.ports = {'8225/tcp': 8225}
# port_mapping = {'clos21/jlab': {'8225/tcp': 8225}}
# c.DockerSpawner.container_spec = {
#     'image': 'clos21/jlab',
#     }
#     'ports': {'8225/tcp': 8225}
#     }
# c.DockerSpawner.extra_host_configs = {'port_bindings': {'8225/tcp': 8225}}
# c.DockerSpawner.image_whitelist = list(port_mapping.keys())

c.LatexConfig.latex_command = 'latexmk'
c.JupyterHub.spawner_class = DockerSpawner
c.JupyterHub.hub_connect_ip = os.environ['HUB_IP']
c.JupyterHub.hub_ip = "0.0.0.0" # Makes accessible on local network
c.JupyterHub.admin_access = True
c.JupyterHub.load_roles = [
    {'name': 'server-rights',
     'description': 'Allows parties to start and stop user servers',
     'scopes': ['servers'],
     'users': ['carlos'],
     'services': [],
     'groups': ['admin-group'],
     }
]

