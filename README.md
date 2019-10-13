# doctl-kubectl [![CircleCI](https://circleci.com/gh/henry40408/doctl-kubectl.svg?style=shield)](https://circleci.com/gh/henry40408/doctl-kubectl) [![Docker Repository on Quay](https://quay.io/repository/henry40408/doctl-kubectl/status "Docker Repository on Quay")](https://quay.io/repository/henry40408/doctl-kubectl)

> Docker image containing `kubectl`, `helm` and `doctl`.

Docker image containing `kubectl`, `helm` and `doctl`. According to [DigitalOcean](https://www.digitalocean.com/docs/kubernetes/how-to/connect-to-cluster/) documentation, it's recommended to connect the cluster with `doctl`. Since most Docker images I found on Docker Hub don't come with `doctl`, it's painful to integrate DigitalOcean Kubernetes with CI, so I create this Docker image by myself.

## Usage example

```sh
$ docker run --rm -it henry40408/doctl-kubectl:latest sh
# kubectl version # Get kubectl version
# helm version # Get helm version
# doctl --version # Get doctl version
```

## Development setup

```sh
$ docker build -t YOUR_USERNAME/doctl-kubectl .
```

## How to test

```sh
$ rbenv install
$ bundle
$ rspec spec
```

## Meta

Distributed under the MIT license. See `LICENSE.txt` for more information.

## Contributing

1. Fork it (<https://github.com/henry40408/doctl-kubectl/fork>)
2. Create your feature branch (`git checkout -b feature/foobar`)
3. Commit your changes (`git commit -am 'Add some foobar'`)
4. Push to the branch (`git push origin feature/foobar`)
5. Create a new Pull Request
