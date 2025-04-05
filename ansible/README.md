# Ewe Infra
Infrastructure repository for booting up a working service infrastructure for deployment applications into. Built on top
of kubernetes, gitea and gitops principles.


## Setup

#### Vaulted Secrets

Within this playbook are ansible-vault encrypted files which require a secret, this should be placed in the `secrets.txt` file in the root of the repository.

Place your text within the `secrets.txt` and run desired playbooks.

#### Copy inventory.example.yml file and add your target servers

```bash
cp inventory.example.yml inventory.yml
```

### Execute

#### Install VPS KVM Setup


The `vps_kvm` playbook will setup 3 controllers and 3 worker microvms using ignite and firecracker provisioning
for you a ready environment for use in setting up whatever services you wish to setup. We reuse this for setting up
k0s 

```bash
make deploy_play FILE=vps_kvm EXTRA_VARS=""
```

Goal:

1. Install containerd binary from its GitHub release.
2. Install firecracker binary from its GitHub release.
3. Install Weave Ignite binary from its GitHub release.
4. Use WeaveIgnite to set up 3 microvm as controller nodes (goal for setup k0s via the vps_k0s and generated custom host files).
5. Use WeaveIgnite to set up 3 microvm as worker nodes (goal for setup k0s via the vps_k0s and generated custom host files).
6. Generate a new custom inventory file containing host IPs and details for controllers and worker nodes.


### Extra Information

Ansible has varying plugins for dynamic inventories:

```bash
ansible.builtin.auto                                    Loads and executes an inventory plugin specified in a YAML config                                                                                                                                                                                                                                                                                                        
ansible.builtin.constructed                             Uses Jinja2 to construct vars and groups based on existing inventory                                                                                                                                                                                                                                                                                                     
ansible.builtin.generator                               Uses Jinja2 to construct hosts and groups from patterns                                                                                                                                                                                                                                                                                                                  
ansible.builtin.host_list                               Parses a 'host list' string                                                                                                                                                                                                                                                                                                                                              
ansible.builtin.ini                                     Uses an Ansible INI file as inventory source                                                                                                                                                                                                                                                                                                                             
ansible.builtin.script                                  Executes an inventory script that returns JSON                                                                                                                                                                                                                                                                                                                           
ansible.builtin.toml                                    Uses a specific TOML file as an inventory source                                                                                                                                                                                                                                                                                          
ansible.builtin.yaml                                    Uses a specific YAML file as an inventory source                
```