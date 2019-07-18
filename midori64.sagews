︠ebbfaa71-9719-4a4e-8a21-0443bbdcedcbs︠
text= "0000000000000000"
key = "00000000000000000000000000000000"
Sbox = [ "c", "a" ,"d" ,"3" ,"e" ,"b" ,"f" ,"7" ,"8" ,"9" ,"1" ,"5" ,"0" ,"2" ,"4" ,"6"]
Pbox =  [0,10,5,15,14,4,11,1,9,3,12,6,7,13,2,8]
M=(
[0,1,1,1],
[1,0,1,1],
[1,1,0,1],
[1,1,1,0]
)
rklsb=(
[0, 0, 0, 1, 0, 1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1],
[0, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0],
[1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 1, 0, 1],
[0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1],
[0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1, 1],
[1, 1, 0, 1, 0, 0, 0, 1, 0, 1, 1, 1, 0, 0, 0, 0],
[0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0],
[0, 0, 0, 0, 1, 0, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0],
[1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1],
[0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 0, 0, 0],
[0, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 1],
[0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0],
[0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 0],
[1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 1, 0, 1, 0],
[1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0]
)


def convert (a):
    if a=="0":
        return [0,0,0,0]
    if a=="1":
        return [0,0,0,1]
    if a=="2":
        return [0,0,1,0]
    if a=="3":
        return [0,0,1,1]
    if a=="4":
        return [0,1,0,0]
    if a=="5":
        return [0,1,0,1]
    if a=="6":
        return [0,1,1,0]
    if a=="7":
        return [0,1,1,1]
    if a=="8":
        return [1,0,0,0]
    if a=="9":
        return [1,0,0,1]
    if a=="a":
        return [1,0,1,0]
    if a=="b":
        return [1,0,1,1]
    if a=="c":
        return [1,1,0,0]
    if a=="d":
        return [1,1,0,1]
    if a=="e":
        return [1,1,1,0]
    if a=="f":
        return [1,1,1,1]
def devert (a):
    if a==[0,0,0,0]: return "0"
    if a==[0,0,0,1]: return "1"
    if a==[0,0,1,0]: return "2"
    if a==[0,0,1,1]: return "3"
    if a==[0,1,0,0]: return "4"
    if a==[0,1,0,1]: return "5"
    if a==[0,1,1,0]: return "6"
    if a==[0,1,1,1]: return "7"
    if a==[1,0,0,0]: return "8"
    if a==[1,0,0,1]: return "9"
    if a==[1,0,1,0]: return "a"
    if a==[1,0,1,1]: return "b"
    if a==[1,1,0,0]: return "c"
    if a==[1,1,0,1]: return "d"
    if a==[1,1,1,0]: return "e"
    if a==[1,1,1,1]: return "f"
State = ([0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0])
for i in [0..3]:
    for j in [0..3]:
        State[j][i] = text[j+4*i]
def KeyAdd (S, k): #podaj w hexowym stringu
    for i in [0..3]:
        for j in [0..3]:
            S[j][i]=convert(S[j][i])
            for l in [0..3]:
                S[j][i][l]=S[j][i][l]^^(convert(k[j+4*i])[l])
            S[j][i] = devert(S[j][i])
    return S
def SubCell (S): #podaj w hexowym stringu
    for i in [0..3]:
        for j in [0..3]:
            a=convert(S[j][i])[0]*8+convert(S[j][i])[1]*4+convert(S[j][i])[2]*2+convert(S[j][i])[3]
            S[j][i]=Sbox[a]
    return S
def ShuffleCell (S):
    temp=([0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0])
    for i in [0..3]:
        for j in [0..3]:
            temp[j][i] = S[Pbox[j+4*i]%4][Pbox[j+4*i]//4]
    S=temp
    return temp
def MixColumns (S):  #podaj w hexowym stringu
    for i in [0..3]:
        temp=[]
        for j in [0..3]:
            temp.append(convert(S[j][i]))
        temp2=[]
        for j in [0..3]:
            vec=[0,0,0,0]
            for l in [0..3]:
                if M[j][l]==1:
                    vec[0]=(temp[l][0]+vec[0])%2
                    vec[1]=(temp[l][1]+vec[1])%2
                    vec[2]=(temp[l][2]+vec[2])%2
                    vec[3]=(temp[l][3]+vec[3])%2
            temp2.append(devert(vec))
        for j in [0..3]:
            S[j][i]=temp2[j]
    return S
WK=""
for i in [0..15]:
    a=convert(key[i])
    b=convert(key[i+16])
    c=[]
    c.append(a[0]^^b[0])
    c.append(a[1]^^b[1])
    c.append(a[2]^^b[2])
    c.append(a[3]^^b[3])
    WK+=devert(c)
RK=[]
for i in [0..14]:
    half=""
    for j in [0..15]:
        half+=key[(i%2)*16+j]
    realkey=""
    for j in [0..15]:
        a=convert(half[j])
        a[3]=a[3]^^rklsb[i][j]
        realkey+=devert(a)
    RK.append(realkey)
def pr ():
    print State[0]
    print State[1]
    print State[2]
    print State[3]
    print ""
pr()
State=KeyAdd(State,WK)
pr()
for i in [0..2]:
    State=SubCell(State)
    pr()
    State=ShuffleCell(State)
    pr()
    State=MixColumns (State)
    pr()
    State=KeyAdd(State,RK[i])
    pr()
State=SubCell(State)
pr()
State=KeyAdd(State,WK)
pr()

︡bef30834-e16d-42ce-bda7-d7322b4085a3︡{"stdout":"['0', '0', '0', '0']\n['0', '0', '0', '0']\n['0', '0', '0', '0']\n['0', '0', '0', '0']\n\n"}︡{"stdout":"['0', '0', '0', '0']\n['0', '0', '0', '0']\n['0', '0', '0', '0']\n['0', '0', '0', '0']\n\n"}︡{"stdout":"['c', 'c', 'c', 'c']\n['c', 'c', 'c', 'c']\n['c', 'c', 'c', 'c']\n['c', 'c', 'c', 'c']\n\n['c', 'c', 'c', 'c']\n['c', 'c', 'c', 'c']\n['c', 'c', 'c', 'c']\n['c', 'c', 'c', 'c']\n\n['c', 'c', 'c', 'c']\n['c', 'c', 'c', 'c']\n['c', 'c', 'c', 'c']\n['c', 'c', 'c', 'c']\n\n['c', 'c', 'd', 'c']\n['c', 'd', 'c', 'c']\n['c', 'c', 'd', 'd']\n['d', 'd', 'd', 'd']\n\n['0', '0', '2', '0']\n['0', '2', '0', '0']\n['0', '0', '2', '2']\n['2', '2', '2', '2']\n\n['0', '2', '0', '2']\n['2', '0', '2', '0']\n['2', '2', '0', '0']\n['2', '0', '0', '2']\n\n['2', '2', '2', '2']\n['0', '0', '0', '0']\n['0', '2', '2', '0']\n['0', '0', '2', '2']\n\n['2', '3', '3', '2']\n['1', '0', '1', '0']\n['1', '2', '2', '0']\n['1', '0', '2', '2']\n\n['d', '3', '3', 'd']\n['a', 'c', 'a', 'c']\n['a', 'd', 'd', 'c']\n['a', 'c', 'd', 'd']\n\n['d', 'c', 'a', 'c']\n['d', '3', 'a', 'c']\n['c', 'd', 'd', 'a']\n['d', 'a', 'd', '3']\n\n['c', '4', 'a', '5']\n['c', 'b', 'a', '5']\n['d', '5', 'd', '3']\n['c', '2', 'd', 'a']\n\n['d', '4', 'a', '5']\n['c', 'a', 'a', '4']\n['c', '5', 'c', '3']\n['c', '2', 'c', 'b']\n\n"}︡{"stdout":"['2', 'e', '1', 'b']\n['0', '1', '1', 'e']\n['0', 'b', '0', '3']\n['0', 'd', '0', '5']\n\n"}︡{"stdout":"['2', 'e', '1', 'b']\n['0', '1', '1', 'e']\n['0', 'b', '0', '3']\n['0', 'd', '0', '5']\n\n"}︡{"done":true}
︠0c2b9220-42b3-4ed3-ac9c-b113773669ba︠









