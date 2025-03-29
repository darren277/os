# os

Experiments in building a simple operating system from the ground up.

## About

This is a minimal "Hello World" operating system project using:
- A tiny 16-bit bootloader (`bootloader.asm`)
- A 32-bit Multiboot kernel (`kernel.asm`)
- GRUB for the boot menu

We containerize QEMU using the official **qemux/qemu** Docker image.

## Usage

Requires `nasm`, `ld`, and `grub-mkrescue` on your host system.

However, I've included a `Dockerfile.build` to build the image with all dependencies.

To build the image, run:
```bash
docker-compose up --build
```

Otherwise, just run:

```bash
make
```

This will produce os.iso and place a copy in qemu/os.iso.

### Docker Commands

1. Build the builder image: `docker-compose build builder`.
2. Run make inside the builder container, creating qemu/os.iso: `docker-compose run --rm builder`.
3. Start QEMU in a container, boot os.iso, and host the web interface (on `http://localhost:8006`): `docker-compose up qemu`.

## Notes

### Bootloader

We are using GRUB so therefore not defining a bootloader ourselves.

However, in `/bootloader/bootloader.asm` there is a very simple bootloader that we may or may not use in the future.
