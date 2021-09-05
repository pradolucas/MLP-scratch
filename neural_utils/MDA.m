## Copyright (C) 2020 Oda1
## 
## This program is free software: you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see
## <https://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {} {@var{retval} =} MDA (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Oda1 <Oda1@ODA1>
## Created: 2020-09-17

function [tri10,tri11,tri12,tri13] = MDA (X, red_dim)
    Nsubject = size(X)(1)/48; %12
    Ntrials_subjects = 48;
    t=(Ntrials_subjects/4)*Nsubject;
    f10=[];
    f11=[];
    f12=[];
    f13=[];
    
    for ii = 0:Nsubject-1
      f10 = cat (1,f10,X((ii*Ntrials_subjects)+1:(ii*Ntrials_subjects)+12,:));
      f11 = cat (1,f11,X((ii*Ntrials_subjects)+13:(ii*Ntrials_subjects)+24,:));
      f12 = cat (1,f12,X((ii*Ntrials_subjects)+25:(ii*Ntrials_subjects)+36,:));
      f13 = cat (1,f13,X((ii*Ntrials_subjects)+37:(ii*Ntrials_subjects)+48,:));
    endfor
    
    U10=mean(f10,1);
    U11=mean(f11,1);
    U12=mean(f12,1);
    U13=mean(f13,1);
    
    aux10(t,:)=f10(t,:)-U10;
    aux11(t,:)=f11(t,:)-U11;
    aux12(t,:)=f12(t,:)-U12;
    aux13(t,:)=f13(t,:)-U13;
      
    S10=aux10'*aux10;
    S11=aux11'*aux11;
    S12=aux12'*aux12;
    S13=aux13'*aux13;
    
    Sw=S10+S11+S12+S13;
    u=mean(X)';
    
    U10=U10';
    U11=U11';
    U12=U12';
    U13=U13';

    a10=576*(U10-u)*(U10-u)';
    a11=576*(U11-u)*(U11-u)';
    a12=576*(U12-u)*(U12-u)';
    a13=576*(U13-u)*(U13-u)';
    
    Sb=a10+a11+a12+a13;
    [Vec,lamb] = eig(Sw,Sb);
    V=Vec(:,1:red_dim);
    
    tri10=V'*f10';
    tri11=V'*f11';
    tri12=V'*f12';
    tri13=V'*f13';
endfunction
