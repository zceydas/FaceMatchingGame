for i=1:6
name=['Fear' num2str(i) 'b_cropped.png'];
I=imread(name);
table(2,i) = entropy(I);
end

