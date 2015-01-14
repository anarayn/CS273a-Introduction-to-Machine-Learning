		% Test function: predict on Xtest
		function Yte = predict(obj,Xte)
			[Ntr,Mtr] = size(obj.Xtrain);					% get size of training, test data
			[Nte,Mte] = size(Xte);
			Yte = repmat(obj.Ytrain(1), [Nte,1]);	% make Ytest the same data type as Ytrain
			K = min(obj.K, Ntr);									% can't have more than Ntrain neighbors
			for i=1:Nte,													% For each test example:
				dist = sum( bsxfun( @minus, obj.Xtrain, Xte(i,:) ).^2 , 2);	% compute sum of squared differences
				%dist = sum( (obj.Xtrain - repmat(Xte(i,:),[Ntr,1]) ).^2 , 2);	% compute sum of squared differences
				[tmp,idx] = sort(dist);							% find nearest neighbors over Xtrain (dimension 2)

				Yte(i)=mean(obj.Ytrain(idx(1:K)));
			end;
		end