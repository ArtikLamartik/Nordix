import subprocess
import os

subprocess.run(['mkdir', '-p', './build'], check=True)
subprocess.run(['nasm', '-f', 'bin', './src/boot.asm', '-o', './build/boot.bin'], check=True)
subprocess.run(['nasm', '-f', 'bin', './src/kernel.asm', '-o', './build/kernel.bin'], check=True)

with open('disk.img', 'wb') as disk:
    with open('./build/boot.bin', 'rb') as boot:
        disk.write(boot.read())
    with open('./build/kernel.bin', 'rb') as kernel:
        disk.write(kernel.read())
    disk.write(b'\x00' * (1048576 * 10 - disk.tell()))

os.remove('./build/boot.bin')
os.remove('./build/kernel.bin')
