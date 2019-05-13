#include <bits/stdc++.h>

using namespace std;

bitset<16> encode(const bitset<16>& in){
    //assign p8 = ^d_in[11:5];
    bool p8=in[10]^in[9]^in[8]^in[7]^in[6]^in[5]^in[4];
    //assign p4 = (^d_in[11:8])^(^d_in[4:2]);
    bool p4=in[10]^in[9]^in[8]^in[7]^in[3]^in[2]^in[1];
    //assign p2 = d_in[11]^d_in[10]^d_in[7]^d_in[6]^d_in[4]^d_in[3]^d_in[1];
    bool p2=in[10]^in[9]^in[6]^in[5]^in[3]^in[2]^in[0];
    //assign p1 = d_in[11]^d_in[ 9]^d_in[7]^d_in[5]^d_in[4]^d_in[2]^d_in[1];
    bool p1=in[10]^in[8]^in[6]^in[4]^in[3]^in[1]^in[0];
    //assign d_out = {d_in[11:5],p8,d_in[4:2],p4,d_in[1],p2,p1};
    cout<<"p1: "<<p1<<"p2: "<<p2<<"p4: "<<p4<<"p8: "<<p8<<endl;
    bitset<16> res;
    res[0]=p1;
    res[1]=p2;
    res[2]=in[0];
    res[3]=p4;
    for (int i=4;i<=6;++i){
        res[i]=in[i-3];
    }
    res[7]=p8;
    for (int i=8;i<=14;++i){
        res[i]=in[i-4];
    }
    return res;
}

int main(){
    cout<<"Note: these bits need to be read backwards.";
    bitset<16> test_in(0b01011000101);
    cout<<"input is:  "<<test_in<<endl;
    cout<<"output is: "<<encode(test_in)<<endl;
    return 0;
}
