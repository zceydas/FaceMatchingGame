function [LeftTop,RightTop,LeftBottom,RightBottom,LeftTop2,RightTop2,LeftBottom2,RightBottom2,ImageList]=pickImage(TargetSide,ContentType,Match,EmotionType)

index={'a','b'}; index=Shuffle(index);
selectdrink=randperm(6);
selectalcohol=randperm(6);

if EmotionType == 1
    emo = 'Neutral'; selectimage=randperm(6);
elseif EmotionType == 2
    emo = 'Joy'; selectimage=randperm(6);
elseif EmotionType == 3
    emo = 'Fear'; selectimage=randperm(6);
elseif EmotionType == 9
    emo='Practice'; selectimage=randperm(6);
    selectimage=randperm(4);
end

image1=[emo num2str(selectimage(1)) index{1} '_cropped']; % only image 1 and 2 can be targets
image2=[emo num2str(selectimage(2)) index{1} '_cropped'];
noMatchImage1=[emo num2str(selectimage(1)) index{2} '_cropped'];
noMatchImage2=[emo num2str(selectimage(2)) index{2} '_cropped'];

if ContentType < 3
    image3=['Neutral' num2str(selectdrink(1))];
    image4=['Neutral' num2str(selectdrink(2))];
else
    image3=['Alcohol' num2str(selectalcohol(1))];
    image4=['Alcohol' num2str(selectalcohol(2))];
end


if TargetSide < 3 % top
    LeftTop=imread(['faces/' image1],'png');
    RightTop=imread(['faces/' image2],'png');
    LeftBottom=imread(['drinks/' image3],'png');
    RightBottom=imread(['drinks/' image4],'png');
else % bottom
    LeftBottom=imread(['faces/' image1],'png');
    RightBottom=imread(['faces/' image2],'png');
    LeftTop=imread(['drinks/' image3],'png');
    RightTop=imread(['drinks/' image4],'png');
end
if Match == 0
    if TargetSide == 1 % top left
        LeftTop2=imread(['faces/' noMatchImage1],'png'); changedimage=noMatchImage1;
        RightTop2=RightTop;
        LeftBottom2=LeftBottom;
        RightBottom2=RightBottom;
    elseif TargetSide == 2 % top right
        RightTop2=imread(['faces/' noMatchImage2],'png'); changedimage=noMatchImage2;
        LeftTop2=LeftTop;
        LeftBottom2=LeftBottom;
        RightBottom2=RightBottom;
    elseif TargetSide == 3 % bottom left
        LeftBottom2=imread(['faces/' noMatchImage1],'png'); changedimage=noMatchImage1;
        LeftTop2=LeftTop;
        RightTop2=RightTop;
        RightBottom2=RightBottom;
    elseif TargetSide == 4 % bottom right
        RightBottom2=imread(['faces/' noMatchImage2],'png'); changedimage=noMatchImage2;
        LeftTop2=LeftTop;
        RightTop2=RightTop;
        LeftBottom2=LeftBottom;
    end
else
    LeftTop2=LeftTop;
    RightTop2=RightTop;
    LeftBottom2=LeftBottom;
    RightBottom2=RightBottom;
    changedimage='NoChange';
end

ImageList{1,1}=image1;
ImageList{1,2}=image2;
ImageList{1,3}=image3;
ImageList{1,4}=image4;
ImageList{1,5}=changedimage;

end
