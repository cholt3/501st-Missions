//Params["personToApply"];
personToApply=_this select 0;
	personToApply  addAction ["<t color='#886600'>forward jump--------U13</t>",
	{
		_namUnit=_this select 0;
		_namThisJumpData=_namUnit getVariable["jumpArray",[]];
		
		
		if((count _namThisJumpData) ==0) then 
		{
			exit;
		};
		
		
		
		comment "data from jump array";
		
		comment "is Jumping-0
		last jump time-1
		jump counter-2
		cooldown-3
		max consecutive jumps-4
		!C or (!A and B)";
		
		_namIsJumping=_namThisJumpData select 0;
		_namLastJumpTime=_namThisJumpData select 1;
		_namJumpCounter=_namThisJumpData select 2;
		_namJumpCooldownTime=_namThisJumpData select 3;
		_namMaxJump=_namThisJumpData select 4;
		comment "A-is jumping B-is cooled C-is over counter /// karnugh map variables";
		
		_namTimeSinceLastJump=time-_namLastJumpTime;
		
		_A=_namIsJumping;
		comment "true if cooled";
		_B=(_namTimeSinceLastJump)>_namJumpCooldownTime;
		comment "true if u just 'double jumped'";
		_C=_namJumpCounter>=_namMaxJump;
		
		if((count _namThisJumpData) !=0) then
		{
			
			_namIsOverCounter=_C;
			_namIsCool=(time-_namLastJumpTime)>=_namJumpCooldownTime;
			
			comment "if ur cooled then reset counter";
			if(_B)then
			{
				_namJumpCounter=0;
				_namUnit setVariable ["jumpArray", [_namIsJumping,_namLastJumpTime,_namJumpCounter,_namJumpCooldownTime,_namMaxJump],true];
			};

			

			if(!_C || {!_A && {_B}}) then 
			{
				_namSpeed=20;
				_namSpeedUp=20;
				
				comment "initiate jump";
				(_namUnit) setVelocity 
				[
				(velocity (_namUnit) select 0)+((vectordir (_namUnit)) select 0)*_namSpeed,
				(velocity (_namUnit) select 1)+((vectordir (_namUnit)) select 1)*_namSpeed,
				(velocity (_namUnit) select 2)+_namSpeedUp
				];
				
				comment "update variables";
				_namIsJumping=true;
				_namLastJumpTime=time;
				_namJumpCounter=_namJumpCounter+1;
				
				_namUnit setVariable ["jumpArray", [_namIsJumping,_namLastJumpTime,_namJumpCounter,_namJumpCooldownTime,_namMaxJump],true];

			}
			else
			{

				hint parseText  format["Can not boost. <t color='#40e0d0'>Cooldown done in</t> <t color='#FF0000'>%1</t>",(_namJumpCooldownTime-(time-_namLastJumpTime))];
				
				if(!_C && _B) then 
				{	
					_namJumpCounter=0;
					_namUnit setVariable ["jumpArray", [_namIsJumping,_namLastJumpTime,_namJumpCounter,_namJumpCooldownTime,_namMaxJump],true];
				};
			};






		};



	}
	,[1],0,false,true,"User14"," driver  _target == _this"];





