import pycuda.autoinit
import pycuda.autoinit
import pycuda.driver as drv
import pycuda.gpuarray as gpuarray
import pycuda.compiler
import numpy as np

f = open("cuda_kernel.cu", 'r')

sm = pycuda.compiler.SourceModule(f.read(), options=['-lineinfo'])


def decrypt_bytes(bytes_in, key):
	# Get a function pointer from the source module
	func = sm.get_function("decrypt_bytes")

	#WHAT SHOULD SIZE BE?????????????

	# Reshaping for simplicity here, not really needed usually
	result = np.reshape(bytes_in, size)

	# Copy data to and from the GPU, and call the function on it
    # Grid and block size simplified here
	func(drv.InOut(result), drv.In(bytes_in), np.int32(size), block=(64,1,1), grid=(size*size/64,1,1))


	# Reshaping the results
    result = np.reshape(bytes_in, size)


