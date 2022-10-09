%------ Gráficos para análisis visual ---------

%----------------- México ---------------------
mexico_num = cleanairbnbmex(:,["accommodates","availability_365","bathroom_text","bedrooms","beds","calculated_host_listings_count","host_acceptance_rate","host_listings_count","host_response_rate","maximum_nights","minimum_nights","number_of_reviews","number_of_reviews_ltm","price","reviews_per_month","review_scores_value","review_scores_rating","review_scores_location","review_scores_communication","review_scores_cleanliness","review_scores_checkin","review_scores_accuracy"]);

%----------------- Brasil ---------------------
brasil_num = cleanairbnbbra(:,["accommodates","availability_365","bathroom_text","bedrooms","beds","calculated_host_listings_count","host_acceptance_rate","host_listings_count","host_response_rate","maximum_nights","minimum_nights","number_of_reviews","number_of_reviews_ltm","price","reviews_per_month","review_scores_value","review_scores_rating","review_scores_location","review_scores_communication","review_scores_cleanliness","review_scores_checkin","review_scores_accuracy"]);

%----------------- Chile ---------------------
chile_num = cleanairbnbchi(:,["accommodates","availability_365","bathrooms_text","bedrooms","beds","calculated_host_listings_count","host_acceptance_rate","host_listings_count","host_response_rate","maximum_nights","minimum_nights","number_of_reviews","number_of_reviews_ltm","price","reviews_per_month","review_scores_value","review_scores_rating","review_scores_location","review_scores_communication","review_scores_cleanliness","review_scores_checkin","review_scores_accuracy"]);

% Matrices de correlación
Matriz_mex=table2array(mexico_num); %esta línea convierte la tabla en matriz
Mat_Corr1=corrcoef(Matriz_mex); %Matriz de correlaciones de México

Matriz_bra=table2array(brasil_num); %esta línea convierte la tabla en matriz
Mat_Corr2=corrcoef(Matriz_bra); %Matriz de correlaciones de Brasil

Matriz_chi=table2array(chile_num); %esta línea convierte la tabla en matriz
Mat_Corr3=corrcoef(Matriz_chi); %Matriz de correlaciones de Chile


% Mapas de calor
hm_mex = heatmap(Mat_Corr1);
hm_chi = heatmap(Mat_Corr3);
hm_bra = heatmap(Mat_Corr2);

