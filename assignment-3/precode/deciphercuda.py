import pycuda.autoinit
import pycuda.autoinit
import pycuda.driver as drv
import pycuda.gpuarray as gpuarray
import pycuda.compiler
import numpy as np
import hashlib

# Generate the source module
f = open("cuda_kernel.cu", 'r')
# lineinfo used to enable assembly profiling in nvvp
sm = pycuda.compiler.SourceModule(f.read(), options=['-lineinfo'])


def decrypt_bytes(bytes_in, key):
	# Get a function pointer from the source module
	func = sm.get_function("decrypt_bytes")

	#WHAT SHOULD SIZE BE?????????????

	size = 512;
	ha = np.fromstring(hashlib.md5(key).digest(), np.uint32)

	#lage result som empty
	#Return a new array with the same shape and type as a given array.
	result = np.empty_like(bytes_in)

	# Reshaping for simplicity here, not really needed usually
	#result = np.reshape(bytes_in, size)

	# Copy data to and from the GPU, and call the function on it
	func(drv.InOut(result), drv.In(bytes_in), drv.In(ha), block=(32,1,1), grid=(512/32,1,1))


	#result = np.reshape(bytes_in, size)
	return result


