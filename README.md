# gcc-install

The `gcc-install.sh` script builds and installs `gcc` from source.
By defauft, it will get `gcc` version `10.2.0`, but this can be configured.

To get started, clone this repo and run the script.

```
git clone https://github.com/edi33416/gcc-install.git
chmod +x gcc-install.sh
./gcc-install.sh
```

This will take some time, as it will download and compile gcc.
After the build is successful, your `gcc` version will be installed in your home directory, in `~/gcc/{gcc-version}`.
In case of `gcc-10.2.0`, it will be installed in `~/gcc/gcc-10.2.0`.

In the end, the script will also create an `activate` script that will update your `PATH`, `LIBRARY_PATH`, `LD_LIBRARY_PATH` and `PS1` env variables.
The `activate` script will be in the resulting `bin` directory; so in the case of `gcc-10.2.0`, it will be in `~/gcc/gcc-10.2.0/bin-gcc-10.2.0/`.

Use `activate` to use `gcc`:
```
source ~/gcc/gcc-10.2.0/bin-gcc-10.2.0/activate
```

To build and install another `gcc` version, just change the `GCC_VERSION` line, ex:
```
GCC_VERSION=9.3.0
```

Contributions are welcomed
