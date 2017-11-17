function tspgui()


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
NIND = 50;          % Number of individuals
MAXGEN = 100;       % Maximum no. of generations
NVAR = 26;          % No. of variables
PRECI = 1;          % Precision of variables
ELITIST = 0.05;     % percentage of the elite population
GGAP = 1-ELITIST;       % Generation gap
STOP_PERCENTAGE = .95;  % percentage of equal fitness individuals for stopping
PR_CROSS = .95;     % probability of crossover
PR_MUT = .05;       % probability of mutation
LOCALLOOP = 0;      % local loop removal
CROSSOVER = 'xalt_edges';   % default crossover operator
MUTATION = 'inversion';     % default mutation operator
REPRESENTATION = 2; % The type of representation used in the ga. 
% 1 - Path, 2 - Adjacency, 3 - Ordinal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% load the data sets
datasetslist = dir('datasets/');datasetslist = dir('datasets/');
datasets = cell( size(datasetslist,1)-2,1);datasets = cell( size(datasetslist,1)-2 ,1);
for i = 1:size(datasets,1);
    datasets{i} = datasetslist(i+2).name;
end

% start with first dataset
data = load(['datasets/' datasets{1}]);
x = data(:,1)/max([data(:,1);data(:,2)]);y = data(:,2)/max([data(:,1);data(:,2)]);
NVAR = size(data,1);

datasets

% representations
representations = ['Path     '; 'Adjacency'; 'Ordinal  '];

% initialise the user interface
fh = figure('Visible','off','Name','TSP Tool','Position',[0,0,1024,768]);
ah1 = axes('Parent',fh,'Position',[.1 .57 .4 .4]);
plot(x,y,'ko')
ah2 = axes('Parent',fh,'Position',[.55 .57 .4 .4]);
axes(ah2);
xlabel('Generation');
ylabel('Distance');
ah3 = axes('Parent',fh,'Position',[.1 .1 .4 .4]);
axes(ah3);
title('Histogram');
xlabel('Distance');
ylabel('Number');

ph = uipanel('Parent',fh,'Title','Settings','Position',[.55 .05 .45 .45]);
reprpopuptxt = uicontrol(ph,'Style','text','String','Representation', ...
    'Position', [0 290 130 20]);
reprpopup = uicontrol(ph,'Style','popupmenu','String', ...
    representations,'Value',REPRESENTATION, ...
    'Position',[130 290 130 20],'Callback',@reprpopup_Callback);
datasetpopuptxt = uicontrol(ph,'Style','text','String','Dataset', ...
    'Position', [0 260 130 20]);
datasetpopup = uicontrol(ph,'Style','popupmenu','String',datasets,'Value',1, ...
    'Position',[130 260 130 20],'Callback',@datasetpopup_Callback);
llooppopuptxt = uicontrol(ph,'Style','text','String','Loop Detection', ...
    'Position',[260 260 130 20]);
llooppopup = uicontrol(ph,'Style','popupmenu','String',{'off','on'},'Value',1, ...
    'Position',[390 260 50 20],'Callback',@llooppopup_Callback); 
ncitiesslidertxt = uicontrol(ph,'Style','text','String','# Cities', ...
    'Position',[0 230 130 20]);
ncitiessliderv = uicontrol(ph,'Style','text','String',NVAR, ...
    'Position',[280 230 50 20]);
nindslidertxt = uicontrol(ph,'Style','text','String','# Individuals', ...
    'Position',[0 200 130 20]);
nindslider = uicontrol(ph,'Style','slider','Max',1000,'Min',10,'Value', ...
    NIND, 'Sliderstep',[0.001 0.05], ...
    'Position',[130 200 150 20],'Callback',@nindslider_Callback);
nindsliderv = uicontrol(ph,'Style','text','String',NIND, ...
    'Position',[280 200 50 20]);
genslidertxt = uicontrol(ph,'Style','text','String','# Generations', ...
    'Position',[0 170 130 20]);
genslider = uicontrol(ph,'Style','slider','Max',1000,'Min',10,'Value', ...
    MAXGEN, 'Sliderstep',[0.001 0.05], ... 
    'Position',[130 170 150 20],'Callback',@genslider_Callback);
gensliderv = uicontrol(ph,'Style','text','String',MAXGEN, ...
    'Position',[280 170 50 20]);
mutslidertxt = uicontrol(ph,'Style','text','String','Pr. Mutation', ...
    'Position',[0 140 130 20]);
mutslider = uicontrol(ph,'Style','slider','Max',100,'Min',0,'Value', ...
    round(PR_MUT*100), 'Sliderstep',[0.01 0.05], ...
    'Position',[130 140 150 20],'Callback',@mutslider_Callback);
mutsliderv = uicontrol(ph,'Style','text','String',round(PR_MUT*100), ...
    'Position',[280 140 50 20]);
crossslidertxt = uicontrol(ph,'Style','text','String','Pr. Crossover', ...
    'Position',[0 110 130 20]);
crossslider = uicontrol(ph,'Style','slider','Max',100,'Min',0,'Value', ... 
    round(PR_CROSS*100), 'Sliderstep',[0.01 0.05], ...
    'Position',[130 110 150 20],'Callback',@crossslider_Callback);
crosssliderv = uicontrol(ph,'Style','text','String',round(PR_CROSS*100), ...
    'Position',[280 110 50 20]);
elitslidertxt = uicontrol(ph,'Style','text','String','% elite', ...
    'Position',[0 80 130 20]);
elitslider = uicontrol(ph,'Style','slider','Max',100,'Min',0,'Value', ...
    round(ELITIST*100),'Sliderstep',[0.01 0.05], ...
    'Position',[130 80 150 20],'Callback',@elitslider_Callback);
elitsliderv = uicontrol(ph,'Style','text','String',round(ELITIST*100), ...
    'Position',[280 80 50 20]);
crossover = uicontrol(ph,'Style','popupmenu', 'String', ...
    {'xalt_edges', 'combin_edges'}, 'Value',1, ...
    'Position',[30 50 130 20],'Callback', @crossover_Callback);
crossover = uicontrol(ph,'Style','popupmenu', 'String', ...
    {'inversion', 'insertion'}, 'Value', 1, ...
    'Position',[260 50 130 20],'Callback', @mutation_Callback);
runbutton = uicontrol(ph,'Style','pushbutton','String','START', ...
    'Position',[0 10 50 30],'Callback',@runbutton_Callback);

set(fh,'Visible','on');

    function datasetpopup_Callback(hObject, eventdata)
        dataset_value = get(hObject,'Value');
        dataset = datasets{dataset_value};
        % load the dataset
        data = load(['datasets/' dataset]);
        x = data(:,1)/max([data(:,1);data(:,2)]);y = data(:,2)/max([data(:,1);data(:,2)]);
        %x = data(:,1);y = data(:,2);
        NVAR = size(data,1); 
        set(ncitiessliderv,'String',size(data,1));
        axes(ah1);
        plot(x,y,'ko') 
    end
    function reprpopup_Callback(hObject, eventdata)
        REPRESENTATION = get(hObject, 'Value');
    end
    function llooppopup_Callback(hObject,eventdata)
        lloop_value = get(hObject,'Value');
        if lloop_value == 1
            LOCALLOOP = 0;
        else
            LOCALLOOP = 1;
        end
    end
    function nindslider_Callback(hObject,eventdata)
        fslider_value = get(hObject,'Value');
        slider_value = round(fslider_value);
        set(hObject,'Value',slider_value);
        set(nindsliderv,'String',slider_value);
        NIND = round(slider_value);
    end
    function genslider_Callback(hObject,eventdata)
        fslider_value = get(hObject,'Value');
        slider_value = round(fslider_value);
        set(hObject,'Value',slider_value);
        set(gensliderv,'String',slider_value);
        MAXGEN = round(slider_value);
    end
    function mutslider_Callback(hObject,eventdata)
        fslider_value = get(hObject,'Value');
        slider_value = round(fslider_value);
        set(hObject,'Value',slider_value);
        set(mutsliderv,'String',slider_value);
        PR_MUT = round(slider_value)/100;
    end
    function crossslider_Callback(hObject,eventdata)
        fslider_value = get(hObject,'Value');
        slider_value = round(fslider_value);
        set(hObject,'Value',slider_value);
        set(crosssliderv,'String',slider_value);
        PR_CROSS = round(slider_value)/100;
    end
    function elitslider_Callback(hObject,eventdata)
        fslider_value = get(hObject,'Value');
        slider_value = round(fslider_value);
        set(hObject,'Value',slider_value);
        set(elitsliderv,'String',slider_value);
        ELITIST = round(slider_value)/100;
        GGAP = 1-ELITIST;
    end
    function crossover_Callback(hObject,eventdata)
        crossover_value = get(hObject,'Value');
        crossovers = get(hObject,'String');
        CROSSOVER = crossovers(crossover_value);
        CROSSOVER = CROSSOVER{1};
    end
    function mutation_Callback(hObject,eventdata)
        mutation_value = get(hObject,'Value');
        mutations = get(hObject,'String');
        MUTATION = mutations(mutation_value);
        MUTATION = MUTATION{1};
    end
    function runbutton_Callback(hObject,eventdata)
        %set(ncitiesslider, 'Visible','off');
        set(nindslider,'Visible','off');
        set(genslider,'Visible','off');
        set(mutslider,'Visible','off');
        set(crossslider,'Visible','off');
        set(elitslider,'Visible','off');
        run_ga(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, ...
        PR_MUT, CROSSOVER, MUTATION, LOCALLOOP, ah1, ah2, ah3, REPRESENTATION);
        end_run();
    end
    function end_run()
        %set(ncitiesslider,'Visible','on');
        set(nindslider,'Visible','on');
        set(genslider,'Visible','on');
        set(mutslider,'Visible','on');
        set(crossslider,'Visible','on');
        set(elitslider,'Visible','on');
    end
end
