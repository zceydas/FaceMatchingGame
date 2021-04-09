for i=1:4
    I=imread(['Practice' num2str(i) 'a'],'png');
    %Crop image, specifying crop rectangle.
    
    I2 = imcrop(I,[200 300 500 700]);
    
    imwrite(I2,['Practice' num2str(i) 'a_cropped.png'])
%     subplot(1,2,1)
%     imshow(I)
%     title('Original Image')
%     subplot(1,2,2)
%     imshow(I2)
%     title('Cropped Image')
    
end