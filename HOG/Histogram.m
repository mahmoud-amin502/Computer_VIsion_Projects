function [ Finalcell ] = Untitled( Blocks1,Blocks2 )

sz1=size(Blocks1);
bin_size=20;
Finalcell=cell(2,2);

for k=1:sz1(1)
    for l=1:sz1(2)   
        temo1=Blocks1{k,l};
        temo2=Blocks2{k,l};
        
        f_vectors=cell(2,2);
        for h=1:2
            for g=1:2
                
                tempo1=Blocks1{k,l}{h,g};
                tempo2=Blocks2{k,l}{h,g};
                
                
                bin=zeros(9,1);
                for i=1:8
                    for j=1:8
                        temp1=tempo1(i,j);
                        temp2=tempo2(i,j);
                        if temp1>=0 && temp1<10
                            bin(1,1)=bin(1,1)+temp2;

                        elseif temp1>=10 && temp1<30
                            d1=30-temp1;
                            d2=temp1-10;
                            g1=d1/bin_size;
                            g2=d2/bin_size;
                            val_1=temp2*g1;
                            val_2=temp2*g2;
                            bin(2,1)=bin(2,1)+val_2;
                            bin(1,1)=bin(1,1)+val_1;
                            
                            
                        elseif temp1>=30 && temp1<50
                            d1=50-temp1;
                            d2=temp1-30;
                            g1=d1/bin_size;
                            g2=d2/bin_size;
                            val_1=temp2*g1;
                            val_2=temp2*g2;
                            bin(3,1)=bin(3,1)+val_2;
                            bin(2,1)=bin(2,1)+val_1;
                        elseif temp1>=50 && temp1<70
                            d1=70-temp1;
                            d2=temp1-50;
                            g1=d1/bin_size;
                            g2=d2/bin_size;
                            val_1=temp2*g1;
                            val_2=temp2*g2;
                            bin(4,1)=bin(4,1)+val_2;
                            bin(3,1)=bin(3,1)+val_1;
                            
                        elseif temp1>=70 && temp1<90
                            d1=90-temp1;
                            d2=temp1-70;
                            g1=d1/bin_size;
                            g2=d2/bin_size;
                            val_1=temp2*g1;
                            val_2=temp2*g2;
                            bin(5,1)=bin(5,1)+val_2;
                            bin(4,1)=bin(4,1)+val_1;
                            
                        elseif temp1>=90 && temp1<110
                            d1=110-temp1;
                            d2=temp1-90;
                            g1=d1/bin_size;
                            g2=d2/bin_size;
                            val_1=temp2*g1;
                            val_2=temp2*g2;
                            bin(6,1)=bin(6,1)+val_2;
                            bin(5,1)=bin(5,1)+val_1;
                            
                        elseif temp1>=110 && temp1<130
                            d1=130-temp1;
                            d2=temp1-110;
                            g1=d1/bin_size;
                            g2=d2/bin_size;
                            val_1=temp2*g1;
                            val_2=temp2*g2;
                            bin(7,1)=bin(7,1)+val_2;
                            bin(6,1)=bin(6,1)+val_1;
                            
                        elseif temp1>=130 && temp1<150
                            d1=150-temp1;
                            d2=temp1-130;
                            g1=d1/bin_size;
                            g2=d2/bin_size;
                            val_1=temp2*g1;
                            val_2=temp2*g2;
                            bin(8,1)=bin(8,1)+val_2;
                            bin(7,1)=bin(7,1)+val_1;
                            
                        elseif temp1>=150 && temp1<170
                            d1=170-temp1;
                            d2=temp1-150;
                            g1=d1/bin_size;
                            g2=d2/bin_size;
                            val_1=temp2*g1;
                            val_2=temp2*g2;
                            bin(9,1)=bin(9,1)+val_2;
                            bin(8,1)=bin(8,1)+val_1;
                        elseif temp1>=170 && temp1<180
                            bin(9,1)=bin(9,1)+temp2;
                        end
                        
                    end 
                end
                s1=sum(bin);
                f_vectors{h,g}=bin./s1;
                
            end
        end
        Finalcell{k,l}=f_vectors;
    end
    
end






end









