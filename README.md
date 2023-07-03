
# Base-container for univention-directory-listener

The container is published in two variations:

- `gitregistry.knut.univention.de/univention/customers/dataport/upx/container-listener-base/listener-base`

  This variation is intended to be used as a base image when building custom
  listener containers. It does not include any listener modules.

- `gitregistry.knut.univention.de/univention/customers/dataport/upx/container-listener-base/listener-base-debug`

  This image does in addition contain a handler named `dummy_handler` which will
  generate output on all events and log them into
  `/var/log/univention/listener_modules/dummy_handler.log`.


## Development setup

The current setup is tailored to be used via `docker compose`:

```sh
docker compose up
```

### One off preparation

Copy `docker-compose.override.yaml.example` to `docker-compose.override.yaml` and adjust as needed.

Alternative: Ensure that the environment variables are set to your needs.


### Connect to locally running `ldap-server`

The defaults in the compose file should work with a locally running
`ldap-server` and `ldap-notifier`.

1. Start the ldap server and notifier from the repository `container-ldap`:

   ```
   docker compose up
   ```

2. Start this container from this repository:

   ```
   docker compose up
   ```

### Connect to UCS machine (optional)

A few secrets and certificates have to be fetched from the targeted UCS machine.
This can be done with the prepared Ansible playbook.

1. Make sure your inventory is prepared.

   Compare `ansible/inventory/hosts.yaml.example` regarding the needed entries.

2. Run the playbook:

   ```sh
   ansible-playbook --inventory="ansible/inventory/hosts.yaml" "ansible/fetch-secrets-from-ucs-machine.yaml"
   ```


## Helm based installation of the debug listener

Basic support to install the debug image into a Kubernetes cluster is provided
via a Helm chart. The generated values are created by the Ansible script from
above.

```sh
helm upgrade --install \
  --values ./helm/values-listener-base-generated.yaml \
  --values ./helm/values-listener-base.yaml \
  listener-base ./helm/listener-base
```


## Logged events

The log file `/var/log/univention/listener_modules/dummy_handler.log` contains
the output of the included dummy handler.


## Required secrets

- `secrets/ldap.secret` - Contains the password to access the LDAP server.

- `ssl/certs/CAcert.pem` - Contains the CA certificate from the UCS machine.


## Environment configuration

The environment is configured in file `docker-compose.override.yaml*`.

The variables are documented inside of the file `docker-compose.yaml`.
