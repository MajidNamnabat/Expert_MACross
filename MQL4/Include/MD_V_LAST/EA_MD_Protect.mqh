/ / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |                                                                                                         E A P r o t e c t . m q h   |  
 / / |                                                                                                     M a j i d   N a m a n a b a t   |  
 / / |                                                                                                 m a j . n a m @ g m a i l . c o m   |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 # p r o p e r t y   c o p y r i g h t   " M a j i d   N a m a n a b a t "  
 # p r o p e r t y   l i n k             " m a j . n a m @ g m a i l . c o m "  
 # p r o p e r t y   v e r s i o n       " 1 . 0 0 "  
 # p r o p e r t y   s t r i c t  
  
 # i n c l u d e   < M D _ V _ L A S T \ \ E A _ M D _ U t i l i t y F u n c t i o n s . m q h >  
  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |                                                                                                                                     |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 c l a s s   C E A P r o t e c t  
     {  
 p r i v a t e :  
       d a t e t i m e                     m _ d t U s i n g S t a r t e d ;  
       i n t                               m _ n A l l o w D a y s ;  
       s t r i n g                         m _ s t r U s e r s A l l o w e d [ ] ;  
       i n t                               I s E x i s t A c c o u n t ( s t r i n g   s t r A c c o u n t ) ;  
 p u b l i c :  
                                           C E A P r o t e c t ( ) ;  
                                         ~ C E A P r o t e c t ( ) ;  
       b o o l                             I s A l l o w e d ( ) ;  
       v o i d                             I n i t ( d a t e t i m e   d t U s i n g S t a r t e d ,   i n t   n A l l o w e d D a y s ,   s t r i n g   s t r A l l o w e d A c c o u n t ) ;  
     } ;  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |                                                                                                                                     |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 C E A P r o t e c t : : C E A P r o t e c t ( )  
     {  
       M q l D a t e T i m e   s t L o c k S t a r t e d ;  
       s t L o c k S t a r t e d . y e a r   =   2 0 2 1 ;  
       s t L o c k S t a r t e d . m o n   =   0 8 ;  
       s t L o c k S t a r t e d . d a y   =   2 8 ;  
       m _ d t U s i n g S t a r t e d   =   S t r u c t T o T i m e ( s t L o c k S t a r t e d ) ;  
       m _ n A l l o w D a y s   =   3 0 ;  
       A r r a y R e s i z e ( m _ s t r U s e r s A l l o w e d ,   1 ) ;  
  
       m _ s t r U s e r s A l l o w e d [ 0 ]   =   " 4 7 0 1 9 2 1 5 " ;  
  
     }  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |                                                                                                                                     |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 C E A P r o t e c t : : ~ C E A P r o t e c t ( )  
     {  
     }  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 b o o l   C E A P r o t e c t : : I s A l l o w e d ( )  
     {  
  
       i n t   n D a y s   =   G e t D a y s E l a p s e d ( m _ d t U s i n g S t a r t e d ) ;  
       s t r i n g   s t r A c c o u n t N a m e   =   I n t e g e r T o S t r i n g ( A c c o u n t N u m b e r ( ) ) ;  
       / / i f ( I S _ E N A B L E _ L O G )   P r i n t   ( " C E A P r o t e c t : : I s A l l o w e d   n D a y s     "   ,   n D a y s   ,   "   m _ d t U s i n g S t a r t e d   "   ,   m _ d t U s i n g S t a r t e d   , "   T i m e C u r r e n t ( )   "   ,   T i m e C u r r e n t ( ) ) ;  
       i f ( n D a y s   <   m _ n A l l o w D a y s   & &   I s E x i s t A c c o u n t ( s t r A c c o u n t N a m e ) > = 0 )  
             r e t u r n   t r u e ;  
         i f ( M Q L I n f o I n t e g e r ( M Q L _ O P T I M I Z A T I O N ) )  
             r e t u r n   t r u e ;  
       i f ( I s T e s t i n g ( ) )  
             r e t u r n   t r u e ;  
       P r i n t   ( " C E A P r o t e c t : : C h e c k   N o t   A l l o w e d   ,   n D a y s : "   ,   n D a y s   ,   "   m _ n A l l o w D a y s   :   "   ,   m _ n A l l o w D a y s   ,   "   s t r A c c o u n t N a m e :   "   ,   s t r A c c o u n t N a m e ) ;  
       r e t u r n   f a l s e ;  
     }  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |                                                                                                                                     |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 v o i d   C E A P r o t e c t : : I n i t ( d a t e t i m e   d t U s i n g S t a r t e d ,   i n t   n A l l o w e d D a y s ,   s t r i n g   s t r A l l o w e d A c c o u n t )  
     {  
       m _ n A l l o w D a y s   =   n A l l o w e d D a y s   ;  
       m _ d t U s i n g S t a r t e d   =   d t U s i n g S t a r t e d ;  
       i f ( I s E x i s t A c c o u n t ( s t r A l l o w e d A c c o u n t ) < 0 )  
           {  
             A r r a y R e s i z e ( m _ s t r U s e r s A l l o w e d ,   A r r a y S i z e ( m _ s t r U s e r s A l l o w e d ) + 1 ) ;  
  
             m _ s t r U s e r s A l l o w e d [ A r r a y S i z e ( m _ s t r U s e r s A l l o w e d ) - 1 ]   =   s t r A l l o w e d A c c o u n t ;  
  
           }  
  
     }  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |                                                                                                                                     |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 i n t   C E A P r o t e c t : : I s E x i s t A c c o u n t ( s t r i n g   s t r A c c o u n t )  
     {  
       f o r ( i n t   n = 0 ;   n < A r r a y S i z e ( m _ s t r U s e r s A l l o w e d ) ;   n + + )  
           {  
             i f ( s t r A c c o u n t   = =   m _ s t r U s e r s A l l o w e d [ n ] )  
                   r e t u r n   n ;  
           }  
       r e t u r n   - 1 ;  
     }  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 