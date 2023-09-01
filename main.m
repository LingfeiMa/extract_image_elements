% 读取图片
path = '.\汉字\';
imgs = dir(fullfile(path));
num = size(imgs,1);
for t=101:num
    name = imgs(t).name;
    img_path = strcat(path,name);

    img=imread(img_path);
    [m,n,h,fxy,pulse,index,img_out] = pre(img);

    

    [img_out,start_done,end_done] = scan_pic(m,n,h,fxy,pulse,index,img_out);
    imshow(img_out)


    [start_done,end_done] = process_1(start_done,end_done);
    [start_done,end_done] = process_2(start_done,end_done);
    for i = (1:size(start_done,1))
        if start_done(i,4) == 3
            start = end_done(i,:);
            end_done(i,:) = start_done(i,:);
            start_done(i,:) = start;
        end
    end
    for i = (1:size(start_done,1))
        if start_done(i,4) == 3
            temp = start_done(i,:);
            start_done(i,:) = end_done(i,:);
            end_done(i,:) = temp;
        end
        x1 = start_done(i,2);
        y1 = start_done(i,3);
        x2 = end_done(i,2);
        y2 = end_done(i,3);
        plot(x1,y1,'*r',x2,y2,'*b')
        xlim([0,200])
        ylim([0,180])
        set(gca,'ydir','reverse');
        line([x1,x2],[y1,y2])
        hold on
    end

     stroke_num = size(start_done,1);
     print = 'This character has %d basic strokes.\n';
     fprintf(print, stroke_num);
     for i = (1:stroke_num)
         if start_done(i,4) == 1
             attribute = 'horizontal';
         elseif start_done(i,4) == 2
             attribute = 'vertical';
         elseif start_done(i,4) == 3
             attribute = 'left-falling';
         elseif start_done(i,4) == 4
             attribute = 'right-falling';
         end
         start_x = start_done(i,2);
         start_y = start_done(i,3);
         loc1 = loc(start_x,start_y);
         end_x = end_done(i,2);
         end_y = end_done(i,3);
         loc2 = loc(end_x,end_y);
         print = 'There is a %s from %s to %s.\n';
         fprintf(print, attribute, loc1, loc2);
     end
end
