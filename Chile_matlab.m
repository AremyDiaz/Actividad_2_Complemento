%Limpieza Matlab Chile 
%Cargamos nuestro set de datos Chile_airbnb_data
%Se realizará la limpieza de nulos, identificación y sustitución de
%outliers 

%---------Identificación de Nulos---------
%Identificamos la matriz de datos faltantes del DataFrame
Matriz_Null= ismissing(Chileairbnbdata);

%Identificamos la cantidad de datos faltantes por Columna
Column_Null= sum(Matriz_Null);

%Identificamos la cantidad de datos faltantes por DataFrame
DataFrame_Null= sum(Column_Null); %Existen 21425 datos nulos 

%---------Sustitución de Nulos---------

%Columna host_response_rate
DataFrame_Fill_0 = fillmissing(Chileairbnbdata,'constant',0,'DataVariables', 'host_response_rate');
%Columna host_acceptance_rate 
DataFrame_Fill_1 = fillmissing(DataFrame_Fill_0,'constant',0,'DataVariables', 'host_acceptance_rate');
%Columna hosTrue_is_superhost
DataFrame_Fill_2 = fillmissing(DataFrame_Fill_1,'constant','False','DataVariables', 'hosTrue_is_superhost');
%Columna host_has_profile_pic
DataFrame_Fill_3 = fillmissing(DataFrame_Fill_2,'constant','False','DataVariables', 'host_has_profile_pic');
%Columna host_identity_verified
DataFrame_Fill_4 = fillmissing(DataFrame_Fill_3,'constant','False','DataVariables', 'host_identity_verified');
%Columna host_listings_count
DataFrame_Fill_5 = fillmissing(DataFrame_Fill_4,'constant',0,'DataVariables', 'host_listings_count');
%bathrooms_text
DataFrame_Fill_6 = fillmissing(DataFrame_Fill_5,'constant',1.5,'DataVariables', 'bathrooms_text');
%bedrooms
DataFrame_Fill_7 = fillmissing(DataFrame_Fill_6,'constant',1,'DataVariables', 'bedrooms');
%beds
DataFrame_Fill_8 = fillmissing(DataFrame_Fill_7,'constant',0,'DataVariables', 'beds');
%review_scores_rating 
DataFrame_Fill_9 = fillmissing(DataFrame_Fill_8,'constant',4.5,'DataVariables', 'review_scores_rating');
%review_scores_accuracy
DataFrame_Fill_10 = fillmissing(DataFrame_Fill_9,'constant',4.7,'DataVariables', 'review_scores_accuracy');
%review_scores_cleanliness
DataFrame_Fill_11 = fillmissing(DataFrame_Fill_10,'constant',4.6,'DataVariables', 'review_scores_cleanliness');
%review_scores_checkin
DataFrame_Fill_12 = fillmissing(DataFrame_Fill_11,'constant',4.8,'DataVariables', 'review_scores_checkin');
%review_scores_communication
DataFrame_Fill_13 = fillmissing(DataFrame_Fill_12,'constant',4.8,'DataVariables', 'review_scores_communication');
%review_scores_location
DataFrame_Fill_14 = fillmissing(DataFrame_Fill_13,'constant',4.8,'DataVariables', 'review_scores_location');
%review_scores_value
DataFrame_Fill_15 = fillmissing(DataFrame_Fill_14,'constant',4.6,'DataVariables', 'review_scores_value');
%reviews_per_month
df_no_null = fillmissing(DataFrame_Fill_15,'constant',0,'DataVariables', 'reviews_per_month');

%Comprobación de nulos 
matriz_prueba= ismissing(df_no_null);
prueba_null= sum(matriz_prueba);

%---------Identificación de Outliers---------
%Identificamos Matriz de outliers mediante método de quartiles
outliers_quartiles = isoutlier(df_no_null,'quartiles','DataVariables',{'host_response_rate','host_listings_count','latitude','longitude', 'accommodates', 'bathrooms_text','bedrooms', 'beds','price', 'minimum_nights', 'maximum_nights','availability_365', 'number_of_reviews','number_of_reviews_ltm', 'review_scores_rating', 'review_scores_accuracy', 'review_scores_cleanliness', 'review_scores_checkin', 'review_scores_communication', 'review_scores_location', 'review_scores_value','reviews_per_month'});
outliers_grubbs = isoutlier(df_no_null,'grubbs','DataVariables',{'host_response_rate','host_listings_count','latitude','longitude', 'accommodates', 'bathrooms_text','bedrooms', 'beds','price', 'minimum_nights', 'maximum_nights','availability_365', 'number_of_reviews','number_of_reviews_ltm', 'review_scores_rating', 'review_scores_accuracy', 'review_scores_cleanliness', 'review_scores_checkin', 'review_scores_communication', 'review_scores_location', 'review_scores_value','reviews_per_month'});
outliers_desv = isoutlier(df_no_null,'mean','DataVariables',{'host_response_rate','host_listings_count','latitude','longitude', 'accommodates', 'bathrooms_text','bedrooms', 'beds','price', 'minimum_nights', 'maximum_nights','availability_365', 'number_of_reviews','number_of_reviews_ltm', 'review_scores_rating', 'review_scores_accuracy', 'review_scores_cleanliness', 'review_scores_checkin', 'review_scores_communication', 'review_scores_location', 'review_scores_value','reviews_per_month'});

%Se identifica la cantidad de outliers por el método de cuartiles
column_outliers_quartil= sum(outliers_quartiles);
%Identificamos la cantidad de outliers por dataframe
dataframe_outliers_quartiles= sum(column_outliers_quartil);

%Se identifica la cantidad de outliers por el método de grubbs
column_outliers_grubbs= sum(outliers_grubbs);
%Identificamos la cantidad de outliers por dataframe
dataframe_outliers_grubbs= sum(column_outliers_grubbs);

%Se identifica la cantidad de outliers por el método de grubbs
column_outliers_desv= sum(outliers_desv);
%Identificamos la cantidad de outliers por dataframe
dataframe_outliers_desv= sum(column_outliers_desv);

%Se descarga la base libre de nulos
writetable(df_no_null,'Chile_no_null.csv','WriteRowNames',true)  
type 'Chile_no_null.csv'
%---------Sustitución de Outliers---------
%Después del análisis gráfico realizado en Python, hacemos el tratamiento
%de outliers
dataFrame_filloutliers_1 = filloutliers(df_no_null,'linear','DataVariables','host_listings_count');

writetable(dataFrame_filloutliers_1,'Chile_out_1.csv','WriteRowNames',true)  
type 'Chile_out_1.csv'


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Filtremos nuestro dataframe por tipo de habitación 
ehome_chile = groupfilter(Chilecleannullout,"room_type",@(x) x=="Entire home/apt","room_type");
sroom_chile = groupfilter(Chilecleannullout,"room_type",@(x) x=="Shared room","room_type");
proom_chile = groupfilter(Chilecleannullout,"room_type",@(x) x=="Private room","room_type");
hroom_chile = groupfilter(Chilecleannullout,"room_type",@(x) x=="Hotel room","room_type");
%---------Correlación de datos---------

%Matriz de correlaciones del Dataframe
matriz_chile=table2array(Chilemodels1); %esta línea convierte la tabla en matriz
mat_corr_chile=corrcoef(matriz_chile); %Matriz de correlaciones
%Se crea un mapa de calor 
h = heatmap(mat_corr_chile);

%Mapa de calor 

%---------Regresión lineal-------------
%Entire home
%MODELO 1: accommodates y bathrooms 
%Variable dependiente: accommodates
filtro_echile= ehome_chile(:,14:15);
filtro_echile = table2array(filtro_echile);
%matriz_echile=table2array(ehome_chile);
y1 =filtro_echile(:,1);
%Variable independiente bathrooms
x1 =filtro_echile(:,2);
%Calculamos el modelo de regresión 
echile_mdl= fitlm(x1,y1)
%Shared room 
%Variable independiente bedrooms
filtro_echile_1= ehome_chile(:,"bedrooms");
filtro_echile_1 = table2array(filtro_echile_1);
%Variable independiente bathrooms
x2 =filtro_echile_1(:,1);
%Calculamos el modelo de regresión 
echile_mdl_1= fitlm(x2,y1);

% CSV 
writetable(dataFrame_filloutliers_1,'Chile_out_1.csv','WriteRowNames',true)  
type 'Chile_out_1.csv'

%Matriz de correlaciones del Dataframe
s_room_chile_1 = groupfilter(Chilemodels1,"room_type",@(x) x=="Entire home/apt","room_type");
matriz_chile_shared=table2array(sroom_chile_1); %esta línea convierte la tabla en matriz
mat_corr_chile_shared=corrcoef(matriz_chile_shared); %Matriz de correlaciones
%Se crea un mapa de calor 
h = heatmap(mat_corr_chile_shared);