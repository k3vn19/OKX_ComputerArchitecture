#include <bits/stdc++.h>

using namespace std;

void prog3(const vector<bitset<8>> &input, const bitset<8> &patin){
    int sz = input.size();
    bitset<8> pat = patin>>4;
    int ctb=0, cto=0;
    for (int i=0;i<sz;i++){
        int addcto = 0;
        for (int j=0;j<5;j++){
            cout<<"comparing "<<(input[i]<<j>>4)<<" with "<<pat<<endl;
            if (pat==(input[i]<<j>>4)){
                cout<<"byte "<<i<<" matched"<<endl;
                ctb++;
                addcto++;
            }
        }
        if (addcto){
            cto++;
        }
    }

    int cts=ctb;
    for (int i=0;i<sz-1;i++){
        auto b1 = input[i];
        auto b2 = input[i+1];
        cout<<"b1 is "<<b1<<endl<<"b2 is "<<b2<<endl;
        for (int j=1;j<=3;j++){
            bitset<8> temp = (b1>>(8-j)) | (b2<<(4+j)>>4);
            cout<<"comparing "<<temp<<" with "<<pat<<endl;
            if (temp == pat){
                cts++;
            }
        }
    }

    cout<<"ctb: "<<ctb<<" cto: "<<cto<<" cts: "<<cts<<endl;
}

int main(){
    vector<bitset<8>> input;
    // input: 10110100 01101101 10011000 11001011
    input.push_back(bitset<8>(0b00101101));
    input.push_back(bitset<8>(0b10110110));
    input.push_back(bitset<8>(0b00011001));
    input.push_back(bitset<8>(0b11010011));
    // pattern is 0110
    bitset<8> pat(bitset<8>(0b01101111));
    prog3(input, pat);
}


/*
output:

comparing 00000010 with 00000110
comparing 00000101 with 00000110
comparing 00001011 with 00000110
comparing 00000110 with 00000110
byte 0 matched
comparing 00001101 with 00000110
comparing 00001011 with 00000110
comparing 00000110 with 00000110
byte 1 matched
comparing 00001101 with 00000110
comparing 00001011 with 00000110
comparing 00000110 with 00000110
byte 1 matched
comparing 00000001 with 00000110
comparing 00000011 with 00000110
comparing 00000110 with 00000110
byte 2 matched
comparing 00001100 with 00000110
comparing 00001001 with 00000110
comparing 00001101 with 00000110
comparing 00001010 with 00000110
comparing 00000100 with 00000110
comparing 00001001 with 00000110
comparing 00000011 with 00000110
b1 is 00101101
b2 is 10110110
comparing 00001100 with 00000110
comparing 00001000 with 00000110
comparing 00000001 with 00000110
b1 is 10110110
b2 is 00011001
comparing 00000011 with 00000110
comparing 00000110 with 00000110
comparing 00001101 with 00000110
b1 is 00011001
b2 is 11010011
comparing 00000110 with 00000110
comparing 00001100 with 00000110
comparing 00001000 with 00000110
ctb: 4 cto: 3 cts: 6
*/
