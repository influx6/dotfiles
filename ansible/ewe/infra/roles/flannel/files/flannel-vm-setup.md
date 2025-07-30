# Setting up flannel manually

1. Start up ectd docker container

```bash
export HostIP="192.168.128.147"
docker run -d -v /usr/share/ca-certificates/:/etc/ssl/certs -p 4001:4001 -p 2380:2380 -p 2379:2379 \
 --name etcd quay.io/coreos/etcd:v3.4.23 etcd \
 --name etcd0 \
 --advertise-client-urls http://${HostIP}:2379,http://${HostIP}:4001 \
 --listen-client-urls http://0.0.0.0:2379,http://0.0.0.0:4001 \
 --initial-advertise-peer-urls http://${HostIP}:2380 \
 --listen-peer-urls http://0.0.0.0:2380 \
 --initial-cluster-token etcd-cluster-1 \
 --initial-cluster etcd0=http://${HostIP}:2380 \
 --initial-cluster-state new
```

Test it:

```bash
etcdctl --endpoints=http://${HostIP}:2379 put greetings "Hello, ectd"
etcdctl --endpoints=http://${HostIP}:2379 get  greetings
```

2. Creation configuration for flannel

```bash
cat > flannel-network-config.json <EOF
{
    "Network": "10.0.0.0/8",
    "SubnetLen": 20,
    "SubnetMin": "10.10.0.0",
    "SubnetMax": "10.99.0.0",
    "Backend": {
        "Type": "vxlan",
        "VNI": 100,
        "Port": 8472
    }
}
EOF
```

Then set this configuration to given key in ectd server: `/coreos.com/network/config`

```bash
etcdctl --endpoints=http://${HostIP}:4001 put /coreos.com/network/config < flannel-network-config.json
```