SHELL = bash
.ONESHELL:
VERSION = 0.0.1
FORMAT = file
OS = linux

clean:
	rm -fr build

.PHONY: build
build: create-package build/hana-buildpack build/package.toml
	pack buildpack package "garethjevans-hana-buildpack-$(VERSION).cnb" --config ./build/package.toml --format "$(FORMAT)"

create-package:
	GO111MODULE=on go install github.com/paketo-buildpacks/libpak/cmd/create-package

.PHONY: build/hana-buildpack
build/hana-buildpack: create-package
	create-package --destination ./build/hana-buildpack --version "0.0.1"

.PHONY: build/package.toml
build/package.toml:
	./scripts/create-package-config.sh ./build/package.toml ./hana-buildpack "$(OS)"
	cat ./build/package.toml
