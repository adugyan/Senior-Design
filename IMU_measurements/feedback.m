function [score] = feedback(type, angle, score, min, max)   
    if (type == 1) % positive and negative feedback
        if (angle >= min && angle <= max) % reward
            score = score + 1; % give points to original score
        end
        if (angle < min || angle > max) % punish
            score = score - 1; % take points to original score
        end
    end
    
    if (type == 2) % positive feedback
        if (angle >= min && angle <= max) % reward
            score = score + 1; % give points to original score
        end
    end
    
    if (type == 3) % negative feedback
        if (angle < min || angle > max) % punish
            score = score - 1; % take points to original score
        end
    end
    
    if (type == 4) % image feedback
        if (angle >= min && angle <= max) % reward smile
            % creating the face
            x0 = 0; % defining the starting point in the coordinate system
            y0 = 0;
            R = 4; % radius of circles
            theta = linspace(0,2*pi,30);
            
            x_head = R*cos(theta);
            y_head = 1.2*R*sin(theta);
            x_left = 0.2*R*cos(theta)-1.5;
            y_left = 0.2*R*sin(theta)+0.5;
            x_right = 0.2*R*cos(theta+pi)+1.5;
            y_right = 0.2*R*sin(theta+pi)+0.5;
            x_nose = [0,-0.5,0.5,0];
            y_nose = 0.5+[-1,-2,-2,-1];
            x_smile = linspace(min(x_left),max(x_right),20);
            y_smile_top = 0.25*(x_smile-mean(x_head)).^2-3;
            y_smile_bot = 0.4*(x_smile-mean(x_head)).^2-3.885;

            head = [x_head+x0;y_head+y0;ones(size(x_head))]*0.2; % creating array of x,y positions
            left = [x_left+x0;y_left+y0;ones(size(x_left))]*0.2;
            right = [x_right+x0;y_right+y0;ones(size(x_right))]*0.2;
            nose = [x_nose+x0;y_nose+y0;ones(size(x_nose))]*0.2;
            smile = [[x_smile,x_smile(end:-1:1)]+x0;[y_smile_top,y_smile_bot(end:-1:1)]+y0;ones(size([x_smile,x_smile]))]*0.2;

            plot_polygon_smile(head);
            plot_polygon_smile(left);
            plot_polygon_smile(right);
            plot_polygon_smile(nose);
            plot_polygon(smile);
        end
        if (angle < min || angle > max) % punish cross
            % creating the no symbol
            x0c = 0; % defining the starting point in the coordinate system
            y0c = 0;
            x0l = -0.3;
            y0l = 0.3;
            
            % creating the no symbol
            R = 4; % raduis of circle
            theta = linspace(0,2*pi,30);
            x_circle = R*cos(theta);
            y_circle = R*sin(theta);
            x_line = [-2*sqrt(2),2*sqrt(2)];
            y_line = [-2*sqrt(2),2*sqrt(2)];

            circleout = [x_circle+x0c;y_circle+y0c;ones(size(x_circle))]; % creating array of x,y
            circlein = [x_circle+x0c;y_circle+y0c;ones(size(x_circle))]*0.9;
            lineup = [x_line+x0l;y_line+y0l;ones(size(x_line))]*0.9;
            linedown = [x_line+x0l;y_line+y0l;ones(size(x_line))]*-0.9;

            plot_polygon_no(circleout);
            plot_polygon_no(circlein);
            plot_polygon_no(lineup);
            plot_polygon_no(linedown);
        end
    end
    
    if (type == 5) % no feedback
        score = 0; % no points because no feedback
    end
end