for i=1:6
    I=imread(['Fear' num2str(i) 'b_cropped.png']);
    I((I==255))=150;
    imwrite(I,['Fear' num2str(i) 'b_cropped.png'])
end