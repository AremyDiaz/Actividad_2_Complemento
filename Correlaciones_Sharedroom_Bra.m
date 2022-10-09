%--------------SHARED ROOM-----------------

%Filtros por columnas
Filtro_Bra4 = Sharedroombra(:,["accommodates","availability_365","bathroom_text","bedrooms","beds","calculated_host_listings_count","host_acceptance_rate","host_listings_count","host_response_rate","maximum_nights","minimum_nights","number_of_reviews","number_of_reviews_ltm","price","reviews_per_month","review_scores_value","review_scores_rating","review_scores_location","review_scores_communication","review_scores_cleanliness","review_scores_checkin","review_scores_accuracy"]);

%---------Correlación de datos Bra4---------

%Matriz de correlaciones - Private room
Matriz4=table2array(Filtro_Bra4); %esta línea convierte la tabla en matriz
Mat_Corr4=corrcoef(Matriz4); %Matriz de correlaciones

%Crear mapa de calor
hm_bra4 = heatmap(Mat_Corr4);


%---------REGRESIÓN LINEAL-------------

%-------------Modelo 1-----------------
%Variable bathrooms
x1=Matriz4(:,3);
%Variable dependiente
y=Matriz4(:,1);

mdl1 = fitlm(x1,y);


%-------------Modelo 2-----------------
%Variable bedrooms
x2=Matriz4(:,4);

mdl2 = fitlm(x2,y);


%-------------Modelo 3-----------------
%Variable beds
x3=Matriz4(:,5);

mdl3 = fitlm(x3,y);


%-------------Modelo 4-----------------
%Variables independientes
X4= [x1,x2]; %X mayúscula porque es múltiple

mdl4 = fitlm(X4,y);


%-------------Modelo 5-----------------
%Variables independientes
X5= [x2,x3]; %X mayúscula porque es múltiple

mdl5 = fitlm(X5,y);


%-------------Modelo 6-----------------
%Variables independientes
X6= [x1,x3]; %X mayúscula porque es múltiple

mdl6 = fitlm(X6,y);


%-------------Modelo 7-----------------
%Variables independientes
X7= [x1,x2,x3]; %X mayúscula porque es múltiple

mdl7 = fitlm(X7,y);