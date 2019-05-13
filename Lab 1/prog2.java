public int[] decode(int d_in[15]) {


//logic [15:1] d_in_corr;
int d_out_corr[15];
int err[4];
int d_out[11];
int s8, s4, s2, s1, p8, p4, p2, p1; 


//pattern: d[11:5] p8 d[4:2] p4 d[1] p2 p1
//d_out[11:5] = d_in[15:9]
for( int i = 4; i<11; i++){
        d_out[i] = d_in[i+4];
}
p8 = d_in[7];
//d_out[4:2] = d_in[7:5];
for( int i = 1; i < 4; i++){
        d_out[ i] = d_in[i+3];
}
p4 = d_in[3];
d_out[0] = d_in[2];
p2 = d_in[2];
p1 = d_in[1]; 
 


//reconstruct parity according to received data
s8 = d_in[10] ^d_in[9] ^ d_in[8] ^d_in[7] ^d_in[6] ^d_in[5 ] ^d_in[4]
s4 =  d_in[10] ^ d_in[9] ^ d_in[8] ^d_in[7] ^ d_in[3] ^d_in[2] ^d_in[1];
s2 = d_in[10] ^d_in[9] ^ d_in[6] ^ d_in[5] ^ d_in[3] ^ d_in[2] ^d_in[0];
s1 = d_in[10] ^ d_in[8] ^d_in[6] ^ d_in[4] ^d_in[3] ^d_in[1] ^d_in[0];


//find where reconstructed parity != received data
err[0] = s1^p1;
err[1]= s2^p2;
err[2]= s4^p4;
err[3]= s8^p8;


//the binary number “err” will point to the bad bit, if any
for(int i = 1; i < 16; i++){
        if(err == i){
                if (d_in[i] == 1){
                        d_in_corr[i] = 0;
                }
                else{
                        d_in_corr[i] = 1;
                }
        }
        else{
                d_in_corr[i] = d_in[i];
        }
}


//select the 11 corrected data bits from the 15 corrected data w/ parity
for(int i = 4; i < 11; i++){
        d_out_corr[i] = d_in_corr[i+4];
}
for(int i = 1; i < 4; i++){
        d_out_corr [i] = d_in_corr[i+3];
}
d_out_corr[0]= d_in_corr[2];


return d_out_corr;




//mem[124]- [127] free to store d_out p s