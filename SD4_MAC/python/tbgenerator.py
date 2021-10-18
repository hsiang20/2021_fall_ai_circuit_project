import random

with open("testdata.in", 'w', newline='') as file_out:
    for i in range(100):
        image=''
        weight=''
        expbias=''
        for x in range(72):
            image += random.choice(['0','1'])
        for y in range(36):
            weight += random.choice(['0','1'])
        for z in range(5):
            expbias += random.choice(['0','1'])

        file_out.writelines('Input %d' % (int(i)+1))
        file_out.writelines('\nImage %s' % image)
        file_out.writelines('\nWeight %s' % weight)
        file_out.writelines('\nExpbias %s' % expbias)
        file_out.writelines('\n')
        file_out.writelines('\n')
