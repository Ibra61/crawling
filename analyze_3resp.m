% analyze atten_con_3resp
% Ks & Im     6/30/16

clear all
%jtype = 'gd'
jtype =  'nsy'

switch jtype
    case 'gd'
        subs{22} = {% Subject 22 (2cpd)
        'ac3r_gd-s22a-20160616T171435',
         };
         subs{5} = { % Subject 5 (2 cpd)
        'ac3r_gd-s05a-20160601T122419',
         };
         subs{6} = { % Subject 6 (2 cpd) inverted responses
         'ac3r_gd-s06a-20160602T190807', 
         };
         subs{7} = { % Subject 7 (2 cpd)
         'ac3r_gd-s07a-20160602T162811',
         };
         subs{8} = { % Subject 8 (2 cpd)
         'ac3r_gd-s08a-20160603T100859', % Ideal Subject
         };
     
        sublist = [22 5 6 7 8];
    case 'nsy'
        subs{1} = { % Ibrahim (2 cpd)
        %'ac3r-s01a-20160526T222431',
        %'ac3r-s01b-20160529T143726',
        'ac3r_nsy-s01c-20160529T162410',
        %'ac3r-s01d-20160529T172147',
        };
        subs{3} = { % Subject 3 (2 cpd)
       'ac3r_nsy-s03a-20160530T105342',
        };
    
        sublist = [1 3];
end
tic;
pcolor = {'r','g', 'b'}; % colors for the three responses
for isub = sublist
    isub
     answers = [];
    nfiles = length(subs{isub});
    for ifile = 1:nfiles
        load(subs{isub}{ifile});
        tmp_answer = p.answer;
        tmp_answer(p.answer==p.cued_side) = 1;
        tmp_answer(p.answer~=p.cued_side) = 2;
        tmp_answer(p.answer==3) = 3;
        answers = cat(3, answers, tmp_answer);
    end
    
    if isub == 6 | isub == 20 % responses inverted
        tmp = answers;
        answers(tmp==1) = 2;
        answers(tmp==2) = 1;
    end
    
    reps = size(answers,3);
    ncons = size(answers,1);
    ntests = size(answers,2);
    
    %dc = min(p.uncued_dlogcon_range):.01:max(p.uncued_dlogcon_range);
    
    presp = zeros(ncons,ntests,3);
    for icon = 1:ncons

        figure
        for iresp = 1:3
            presp(icon, :, iresp) = sum(answers(icon, :, :)==iresp, 3)/reps;
            h(iresp)=plot(p.uncued_dlogcon_range,presp(icon, :, iresp),pcolor{iresp});
            hold on
        end
      toc;  
        
      
      
      
      
      
      
      switch jtype
            case 'gd'
        title(sprintf('Subject %d: %d%% contrast',isub, p.cued_cons(icon)))
        xlabel('Difference in log contrast (cued target - uncued target)');
        ylabel('P(response)');
        legend(h,{'Cued target higher', 'Uncued target higher', 'Targets equal'});
        grid on;
            case 'nsy'
        title(sprintf('Subject %d: %d%% contrast',isub, p.cued_cons(icon)))
        xlabel('Mean Difference in log contrast (cued target - uncued target)');
        ylabel('P(response)');
        legend(h,{'Mean Cued target higher', 'Mean Uncued target higher', ' Mean Targets equal'}); 
        grid on;
        end      
                
     end   
end