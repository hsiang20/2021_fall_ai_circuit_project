import argparse
import numpy as np
import time

def count(string,target):
    count=0
    for i in string:
        if i == str(target):
            count+=1
    return count
    pass
def add2(a,b,digit):
    while(len(a) < int(digit)):
        a = "0" + a
    while(len(b) < int(digit)):
        b = "0" + b
    ans = ""
    tmp = 0
    for i in range(int(digit)):
        tmpp = tmp + int(a[int(digit)-i-1]) + int(b[int(digit)-i-1])
        tmp = tmpp//2
        ans = str(tmpp % 2) + ans
    return ans
def minus2(a,b,digit):        
    while(len(a) < int(digit)):
        a = "0" + a
    while(len(b) < int(digit)):
        b = "0" + b
    ans = ""
    tmp = 0
    for i in range(int(digit)):
        tmpp = tmp + int(a[int(digit)-i-1]) - int(b[int(digit)-i-1])
        if tmpp < 0:
            tmp = -1
            tmpp +=2
        else:
            tmp = 0
        
        ans = str(tmpp) + ans
    return ans

class MAC():
    def __init__(self, args):
        pass
    
    def parser(self): 
        with open("%s" % args.input, 'r', newline='') as file_in:
            f = file_in.read().splitlines()
            
            self.image=[]
            self.weight=[]
            self.expbias=[]
            for lines in f:
                value_list = lines.split(' ')
                
                if value_list[0]=="Image":
                    self.image.append(str(value_list[-1]))
                    
                elif value_list[0]=="Weight":
                    self.weight.append(str(value_list[-1]))
                    
                elif value_list[0]=="Expbias":
                    self.expbias.append(str(value_list[-1]))

            self.datasize = len(self.image)
                

    def ppg(self):
        self.imagesplit=[]
        self.weightsplit=[]
        self.exp=[]
        self.signedpp=[]
        self.maxexp=[]
        for i in range(self.datasize):
            self.imagesplit.append([])
            self.weightsplit.append([])
            self.exp.append([])
            self.signedpp.append([])
            
            for j in range(9):
                self.imagesplit[i].append(self.image[i][j*8:(j*8+8)])
                self.weightsplit[i].append(self.weight[i][j*4:(j*4+4)])
                
                if count(self.weightsplit[i][j][1:4],'1') == 3:
                    zero_weight = '1'
                else:
                    zero_weight = '0'
                    
                
                if count(self.imagesplit[i][j][1:8],'0') == 7:
                    zero_image = '1'
                else:
                    zero_image = '0'
                    
                if count(zero_weight+zero_image,'0') == 2:
                    zero_detect = '0'
                else:
                    zero_detect = '1'
          
                
                
                if int(zero_detect):
                    self.signedpp[i].append("00000")
                    self.exp[i].append("00000")
                else:
                    self.exp[i].append(add2(self.imagesplit[i][j][1:5],self.weightsplit[i][j][1:],5))
                    if self.weightsplit[i][j][0] == self.imagesplit[i][j][0]:
                        sign = '0'
                    else:
                        sign = '1'
                    self.signedpp[i].append(sign + '1' + self.imagesplit[i][j][5:])
    
            self.maxexp.append(max(self.exp[i][0],self.exp[i][1],self.exp[i][2],self.exp[i][3],self.exp[i][4],self.exp[i][5],self.exp[i][6],self.exp[i][7],self.exp[i][8]) )
    def alignment(self):
        self.alignedpp=[]
        for i in range(self.datasize):
            self.alignedpp.append([])
            for j in range(9):
                expdiff = minus2(self.maxexp[i],self.exp[i][j],5)
                shift = 0
                for k in range(5):
                    shift += (2**k)*int(expdiff[4-k])
                tmp = "0"*shift + self.signedpp[i][j][1:] + "0"*11
                tmpp = tmp[0:15]
                if int(self.signedpp[i][j][0]):
                    self.alignedpp[i].append(minus2("1"+"0"*16,tmpp,17)[1:])
                else:
                    self.alignedpp[i].append('0'+tmpp)
    def adder(self):
        self.adder=[]
        for i in range(self.datasize):
            tmp01 = add2(self.alignedpp[i][0],self.alignedpp[i][1],17)
            tmp23 = add2(self.alignedpp[i][2],self.alignedpp[i][3],17)
            tmp45 = add2(self.alignedpp[i][4],self.alignedpp[i][5],17)
            tmp67 = add2(self.alignedpp[i][6],self.alignedpp[i][7],17)
            tmp0123 = add2(tmp01,tmp23,18)
            tmp4567 = add2(tmp45,tmp67,18)
            tmp01234567 = add2(tmp0123,tmp4567,19)
            self.adder.append(add2(tmp01234567,self.alignedpp[i][8],20))
            
            
            
            
    def output(self): 
        with open("%s" % args.output, 'w', newline='') as file_out:
            for i in range(self.datasize):
                file_out.writelines('Input %d'% (int(i)+1))
                file_out.writelines('\nSigned_pp %s'% self.signedpp[i][0]+' '+self.signedpp[i][1]+' '+self.signedpp[i][2]+' '+self.signedpp[i][3]+' '+self.signedpp[i][4]+self.signedpp[i][5]+self.signedpp[i][6]+self.signedpp[i][7]+self.signedpp[i][8])
                file_out.writelines('\nExp %s'% self.exp[i][0]+' '+self.exp[i][1]+' '+self.exp[i][2]+' '+self.exp[i][3]+' '+self.exp[i][4]+self.exp[i][5]+self.exp[i][6]+self.exp[i][7]+self.exp[i][8])
                file_out.writelines('\nMaxExp %s'% self.maxexp[i])
                file_out.writelines('\nAligned_pp %s'% self.alignedpp[i][0]+' '+self.alignedpp[i][1]+' '+self.alignedpp[i][2]+' '+self.alignedpp[i][3]+' '+self.alignedpp[i][4]+self.alignedpp[i][5]+self.alignedpp[i][6]+self.alignedpp[i][7]+self.alignedpp[i][8])
                file_out.writelines('\nAdder %s'% self.adder[i])
                file_out.writelines('\n')
                file_out.writelines('\n')



            
        
if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument("--input", type=str, default = '',help="Input file root.")
    parser.add_argument("--output", type=str, default = '',help="Output file root.")
    args = parser.parse_args()

    mac = MAC(args)
    

    mac.parser()
    mac.ppg()
    mac.alignment()
    mac.adder()
    mac.output()
    
