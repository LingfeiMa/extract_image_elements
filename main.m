% 读取图片
path = '.\汉字\';
imgs = dir(fullfile(path));
num = size(imgs,1);
for t=101:num
    name = imgs(t).name;
    img_path = strcat(path,name);
    % 图像预处理
    img=imread(img_path);
    [m,n,h,fxy,pulse,index,img_out] = pre(img);
%     imshow(img_out)
    
    % 扫描图片，找笔画
    [img_out,start_done,end_done] = scan_pic(m,n,h,fxy,pulse,index,img_out);
    imshow(img_out)

%     % 笔画处理--连接、删除
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
%     save_path = strcat('.\process\',num2str(t-2),'.png');
%     saveas(1,save_path);
%     close(1)
    % 输出信息（Excel表格）
    % 把汉字放入九宫格
    %  _ _ _
    % |_|_|_|
    % |_|_|_|   左上中下，中上心下，右上中下
    % |_|_|_|
    % 汉字|笔画数（扫描出来的）|笔画1属性、起点位置、终点位置|笔画2属性、起点位置、终点位置。。。。
%     stroke_num = size(start_done,1);
%     print = 'This character has %d basic strokes.\n';
%     fprintf(print, stroke_num);
%     for i = (1:stroke_num)
%         if start_done(i,4) == 1
%             attribute = 'horizontal';
%         elseif start_done(i,4) == 2
%             attribute = 'vertical';
%         elseif start_done(i,4) == 3
%             attribute = 'left-falling';
%         elseif start_done(i,4) == 4
%             attribute = 'right-falling';
%         end
%         start_x = start_done(i,2);
%         start_y = start_done(i,3);
%         loc1 = loc(start_x,start_y);
%         end_x = end_done(i,2);
%         end_y = end_done(i,3);
%         loc2 = loc(end_x,end_y);
%         print = 'There is a %s from %s to %s.\n';
%         fprintf(print, attribute, loc1, loc2);
%     end
    
    
    % 生成一张白底坐标，把记录的起点终点连成线

    
    % 如何描述笔画之间的关系？---
    % 从上到下，从左到右
    
    % 找到了笔画起点与终点----用笛卡尔坐标系判断笔画是否相交
end