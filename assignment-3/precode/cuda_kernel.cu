__device__ void decipher(unsigned int, unsigned int*, unsigned int const*);


__global__ void decrypt_bytes(unsigned int *decrypted, unsigned char *key, unsigned int *encrypted)
{
    const int tx = threadIdx.x + (blockIdx.x * blockDim.x);
    //finne ut hvordan man deler de opp paa traadene 
    unsigned int deciphered[2];
    deciphered[0] = encrypted[0];
    deciphered[1] = encrypted[1];
    decipher(32, deciphered, (unsigned int*)key);
    decrypted[0] = deciphered[0] ^ (unsigned int)1;
    decrypted[1] = deciphered[1] ^ (unsigned int)2;
    int i = tx; // 2;
    
    deciphered[0] = encrypted[i];
    deciphered[1] = encrypted[i+1];
    decipher(32, deciphered, (unsigned int*)key);
    decrypted[i] = deciphered[0] ^ encrypted[i-2];
    decrypted[i+1] = deciphered[1] ^ encrypted[i-1];
    i += 2;
}   


__device__ void decipher(unsigned int num_rounds, unsigned int v[2], unsigned int const key[4])
{
    /*
    num_rounds -- the number of iterations in the algorithm, 32 is reccomended
    input_data -- the input data to use, 32 bits of the first 2 elements are used
    key -- 128-bit key to use
    */
    unsigned int i;
    unsigned int v0=v[0], v1=v[1], delta=0x9E3779B9, sum=delta*num_rounds;

    for (i=0; i < num_rounds; i++) {
        v1 -= (((v0 << 4) ^ (v0 >> 5)) + v0) ^ (sum + key[(sum>>11) & 3]);
        sum -= delta;
        v0 -= (((v1 << 4) ^ (v1 >> 5)) + v1) ^ (sum + key[sum & 3]);
    }
    v[0]=v0; v[1]=v1;
}