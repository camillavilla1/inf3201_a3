__device__ void decipher(num_rounds, input_data, key);

__global__ char decrypt_bytes(bytes_in, key) {
	//Gett thread ID
	const int tx = threadIdx.x + (blockIdx.x * blockDim.x);

	//Do the calculation
	//Use tx to something!?!?!
	//something = decipher(num_rounds, input_data, key);
}

__device__ char decipher(num_rounds, input_data, key) {
    /*XTEA implementation in python, decryption.

    Modified version from Simon Biewald (http://varbin.github.io/xtea/)

    Arguments:
    num_rounds -- the number of iterations in the algorithm, 32 is reccomended
    input_data -- the input data to use, 32 bits of the first 2 elements are used
    key -- 128-bit key to use

    returns -- a numpy array containing the deciphered data


    dtype = 32-bit big-endian integer
    */
    uint32_t arrayz[a][b];
    char v0 = input_data[0];
    char v1 = input_data[1];
    char delta = 0x9e3779b9L;
    char mask = 0xffffffffL;
    char sum = (delta*num_rounds) & mask;
    int rounds;
    // ^  	bitwise XOR (eXclusive OR)
    for (rounds = 0; rounds < num_rounds; rounds++)
    {
        v1[rounds] = (v1 - (((v0<<4 ^ v0>>5) + v0) ^ (sum + key[sum>>11 & 3]))) & mask;
        sum = (sum - delta) & mask;
        v0 = (v0 - (((v1<<4 ^ v1>>5) + v1) ^ (sum + key[sum & 3]))) & mask;
    }
    return arrayz[v0][v1];
}