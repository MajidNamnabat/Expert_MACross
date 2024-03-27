/ / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |                                                                                   C h a r t C h a r a c t e r i s t i c s . m q h   |  
 / / |                                                                                                       M a j i d   N a m n a b a t   |  
 / / |                                                                                           h t t p s : / / w w w . m q l 5 . c o m   |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 # p r o p e r t y   c o p y r i g h t   " M a j i d   N a m n a b a t "  
 # p r o p e r t y   l i n k             " h t t p s : / / w w w . m q l 5 . c o m "  
 # p r o p e r t y   s t r i c t  
 # i n c l u d e   < E A _ M A C D _ D i v . m q h >  
 # i n c l u d e   < E A _ M A C r o s s D i s . m q h >  
 # i n c l u d e   < E A _ C a n d l e S t i c k P a t t e r n s . m q h >  
  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |   d e f i n e s                                                                                                                     |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / /   # d e f i n e   M a c r o s H e l l o       " H e l l o ,   w o r l d ! "  
 / /   # d e f i n e   M a c r o s Y e a r         2 0 1 0  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |   D L L   i m p o r t s                                                                                                             |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / /   # i m p o r t   " u s e r 3 2 . d l l "  
 / /       i n t             S e n d M e s s a g e A ( i n t   h W n d , i n t   M s g , i n t   w P a r a m , i n t   l P a r a m ) ;  
 / /   # i m p o r t   " m y _ e x p e r t . d l l "  
 / /       i n t             E x p e r t R e c a l c u l a t e ( i n t   w P a r a m , i n t   l P a r a m ) ;  
 / /   # i m p o r t  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |   E X 5   i m p o r t s                                                                                                             |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / /   # i m p o r t   " s t d l i b . e x 5 "  
 / /       s t r i n g   E r r o r D e s c r i p t i o n ( i n t   e r r o r _ c o d e ) ;  
 / /   # i m p o r t  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 e n u m   E N U M _ M V S T A T E S  
     {  
       E N U M _ M V _ C R O S S O V E R ,  
       E N U M _ M V _ D I S T A N C E _ S U I T A B L E _ O P E N ,  
       E N U M _ M V _ N E A R I N G ,  
       E N U M _ M V _ F A R I N G ,  
       E N U M _ M V _ D I S T A N C E _ S U I T A B L E _ C L O S E  
     } ;  
 s t r u c t   s t D i v e r g e n c e  
     {  
       E N U M _ D I V E R G E N C E _ C L A S S   m _ n D i v e r g e n c e C l a s s ;  
       i n t                               m _ n P e r i o d ;  
       d o u b l e                         m _ f P r o b a b i l i t y ;  
     } ;  
 s t r u c t   s t C h a r a c t e r  
     {  
       s t D i v e r g e n c e             s t D i v e r g e n c e _ P r v 2 C a n d l e ;  
       E N U M _ C A N D L E _ P A T T E R N S   s t C a n d l e P a t t e r n     ;  
       d a t e t i m e                     d t T i m e ;  
     } ;  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |                                                                                                                                     |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 c l a s s   C h a r t C h a r a c t e r i s t i c s  
     {  
 p r i v a t e :  
 p u b l i c   :  
       s t C h a r a c t e r                   m _ s t H i s t o r y [ ] ;  
       i n t                                   m _ n H i s t o r y L e n ;  
       C S i g n a l C r o s s M V _ D i s   m _ M V C r o s s D i s   ;  
       E N U M _ M V S T A T E S           m _ n M V S t a t e s ;  
  
                                           C h a r t C h a r a c t e r i s t i c s ( ) ;  
                                         ~ C h a r t C h a r a c t e r i s t i c s ( ) ;  
  
       d o u b l e                         G e t S l o p e _ S t C r o s s O v e r ( ) ;  
       v o i d                             C h e c k E x i s t _ I n s e r t H i s t o r y ( d a t e t i m e   d t T i m e ) ;  
       s t D i v e r g e n c e             G e t D i v e r g e n c e ( d a t e t i m e   d t T i m e ) ;  
       i n t                               D i s t a n c e B a r _ C a n d l e _ D i v e r g e n c e ( i n t   n C o m m a n d ) ;  
     } ;  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |                                                                                                                                     |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 C h a r t C h a r a c t e r i s t i c s : : C h a r t C h a r a c t e r i s t i c s ( )  
     {  
       / / A r r a y S e t A s S e r i e s ( m _ s t H i s t o r y , t r u e ) ;  
       m _ n H i s t o r y L e n   =   - 1 ;  
  
     }  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |                                                                                                                                     |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 C h a r t C h a r a c t e r i s t i c s : : ~ C h a r t C h a r a c t e r i s t i c s ( )  
     {  
     }  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |                                                                                                                                     |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 d o u b l e   C h a r t C h a r a c t e r i s t i c s : : G e t S l o p e _ S t C r o s s O v e r ( )  
     {  
       i f ( m _ M V C r o s s D i s . G e t P r i c e _ C r o s s O v e r ( )   <   0 )  
             r e t u r n   - 1 0 0 0 . f ;  
       d o u b l e   f D e l t a Y   =   ( ( B i d + A s k ) / 2   -   m _ M V C r o s s D i s . G e t P r i c e _ C r o s s O v e r ( ) )   /   _ P o i n t ;  
  
       d o u b l e   f D e l t a X   =   ( d o u b l e )   G e t B a r s E l a p s e d ( m _ M V C r o s s D i s . G e t D a t e _ C r o s s O v e r ( ) )   ;  
  
       d o u b l e   f S l o p e   =   f D e l t a Y   /   f D e l t a X   ;  
       d o u b l e   f A n g l e   =   M a t h A r c t a n ( f S l o p e ) /   3 . 1 4 1 5 9 6 5   *   1 8 0   ;  
  
  
       r e t u r n   f A n g l e ;  
     }  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |                                                                                                                                     |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 v o i d                             C h a r t C h a r a c t e r i s t i c s : : C h e c k E x i s t _ I n s e r t H i s t o r y ( d a t e t i m e   d t T i m e )  
     {  
 / / P r i n t   ( "   C h e c k E x i s t _ I n s e r t H i s t o r y   F u n c t i o n   :   "   ,   d t T i m e   ,   "   m _ n H i s t o r y L e n   :   "   ,   m _ n H i s t o r y L e n ) ;  
       i f ( m _ n H i s t o r y L e n > = 0   & &   m _ n H i s t o r y L e n < A r r a y S i z e ( m _ s t H i s t o r y )   & &   m _ s t H i s t o r y [ m _ n H i s t o r y L e n ] . d t T i m e   = =   d t T i m e )  
             r e t u r n ;  
       i f ( m _ n H i s t o r y L e n > = A r r a y S i z e ( m _ s t H i s t o r y ) - 1   | |   m _ n H i s t o r y L e n < 0 )  
           {  
             A r r a y R e s i z e ( m _ s t H i s t o r y , A r r a y S i z e ( m _ s t H i s t o r y ) + 2 0 ) ;  
           }  
       i f ( m _ n H i s t o r y L e n < 0 )  
             m _ n H i s t o r y L e n = 0 ;  
       m _ s t H i s t o r y [ m _ n H i s t o r y L e n ] . d t T i m e = d t T i m e ;  
       m _ s t H i s t o r y [ m _ n H i s t o r y L e n ] . s t D i v e r g e n c e _ P r v 2 C a n d l e . m _ n D i v e r g e n c e C l a s s   =   E N U M _ D I V E R G E N C E _ U N K N O W N   ;  
       m _ s t H i s t o r y [ m _ n H i s t o r y L e n ] . s t C a n d l e P a t t e r n   =   U N K N O W N _ P A T T E R N   ;  
       m _ n H i s t o r y L e n + + ;  
     } ;  
  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |                                                                                                                                     |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 s t D i v e r g e n c e   C h a r t C h a r a c t e r i s t i c s : : G e t D i v e r g e n c e ( d a t e t i m e   d t T i m e )  
     {  
       s t D i v e r g e n c e   d i v ;  
       d i v . m _ n D i v e r g e n c e C l a s s   =   E N U M _ D I V E R G E N C E _ N O N E   ;  
       / / P r i n t   ( " C h a r t C h a r a c t e r i s t i c s : : G e t D i v e r g e n c e   "   , m _ n H i s t o r y L e n   , "   "   ,   A r r a y S i z e ( m _ s t H i s t o r y )     ) ;  
       i f ( m _ n H i s t o r y L e n - 1 > = A r r a y S i z e ( m _ s t H i s t o r y ) | |   m _ n H i s t o r y L e n < 0 )  
             r e t u r n   d i v ;  
       i f ( m _ s t H i s t o r y [ m _ n H i s t o r y L e n - 1 ] . d t T i m e   = =   d t T i m e )  
           {  
             d i v   =   m _ s t H i s t o r y [ m _ n H i s t o r y L e n - 1 ] . s t D i v e r g e n c e _ P r v 2 C a n d l e   ;  
  
           }  
       r e t u r n   d i v ;  
  
     }  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
   i n t   C h a r t C h a r a c t e r i s t i c s : : D i s t a n c e B a r _ C a n d l e _ D i v e r g e n c e ( i n t   n C o m m a n d )  
   {  
       i f ( m _ n H i s t o r y L e n < = 1 )  
             r e t u r n   - 1 ;    
       i f ( G e t B a r s E l a p s e d ( m _ s t H i s t o r y [ m _ n H i s t o r y L e n - 1 ] . d t T i m e ) > 1 )  
             r e t u r n   - 1 ;  
       d a t e t i m e   d t C a n d l e   =   0 ,   d t D i v e r g e n c e   =   0   ;    
       i n t   n B a r s   =   - 1 ;  
       i n t   n S t a r t I n d e x   =   m _ n H i s t o r y L e n - 4   > =   0   ?   m _ n H i s t o r y L e n - 4   :   0   ;  
        
       f o r ( i n t   n = n S t a r t I n d e x ; n < = m _ n H i s t o r y L e n - 1 ; n + + )  
       {  
             E N U M _ C A N D L E _ P A T T E R N S   n C a n d l e P a t t e r n   =   m _ s t H i s t o r y [ n ] . s t C a n d l e P a t t e r n   ;  
             E N U M _ D I V E R G E N C E _ C L A S S   n D i v e r g e n c e C l a s s   =   m _ s t H i s t o r y [ n ] . s t D i v e r g e n c e _ P r v 2 C a n d l e . m _ n D i v e r g e n c e C l a s s   ;  
             / / P r i n t   ( "   D i s t a n c e B a r _ C a n d l e _ D i v e r g e n c e   "   ,   E n u m T o S t r i n g ( n C a n d l e P a t t e r n )   ,   "   "   , E n u m T o S t r i n g ( n D i v e r g e n c e C l a s s )   , "   "   ) ;  
             i f ( (   n C a n d l e P a t t e r n   ! =   U N K N O W N _ P A T T E R N   & &   n C a n d l e P a t t e r n   ! =   E R R O R _ O C C U R E D ) )  
             {  
                   i f   ( n C o m m a n d   = =   O P _ B U Y   & &   C h e c k B i t ( ( i n t ) n C a n d l e P a t t e r n , 1 2 ) = = 0   / * B E A R I S H * /   )  
                         {  
                           d t C a n d l e   =   m _ s t H i s t o r y [ n ] . d t T i m e   ;    
                         }  
                     e l s e   i f   ( n C o m m a n d   = =   O P _ S E L L   & &   C h e c k B i t ( ( i n t ) n C a n d l e P a t t e r n , 1 2 ) = = 1   / * B U L L I S H * /   )  
                         {  
                           d t C a n d l e   =   m _ s t H i s t o r y [ n ] . d t T i m e   ;    
                         }  
             }  
             i f (   n D i v e r g e n c e C l a s s   ! =   E N U M _ D I V E R G E N C E _ N O N E   & &  
                   n D i v e r g e n c e C l a s s   ! =   E N U M _ D I V E R G E N C E _ U N K N O W N )  
             {  
                   i f ( n C o m m a n d   = =   O P _ B U Y   & &   (   C h e c k B i t ( n D i v e r g e n c e C l a s s , 1 )   = =   0   & &    
                                                               C h e c k B i t ( n D i v e r g e n c e C l a s s , 0 )   = =   1   ) )  
                     {  
                         d t D i v e r g e n c e   =   m _ s t H i s t o r y [ n ] . d t T i m e   ;    
                     }  
                 e l s e   i f (   n C o m m a n d   = =   O P _ S E L L   & &   (   C h e c k B i t ( n D i v e r g e n c e C l a s s , 1 )   = =   1   & &    
                                                               C h e c k B i t ( n D i v e r g e n c e C l a s s , 0 )   = =   0   ) )  
                 {      
                         d t D i v e r g e n c e   =   m _ s t H i s t o r y [ n ] . d t T i m e   ;    
                 }  
             }  
       }  
       i f ( d t C a n d l e   >   0   & &   d t D i v e r g e n c e   >   0   )  
       {  
             / / i f ( I S _ E N A B L E _ L O G )   P r i n t ( "   D i s t a n c e B a r _ C a n d l e _ D i v e r g e n c e   F u n c t i o n   :   "   ,   d t C a n d l e   ,     "   "   ,   d t D i v e r g e n c e   ,   "   "   ,   n B a r s )  
             / * i f ( d t C a n d l e   = =   d t D i v e r g e n c e )  
                   r e t u r n   0 ; * /  
             i n t   d u r a t i o n   = ( i n t ) ( M a t h A b s ( d t C a n d l e   -   d t D i v e r g e n c e )   /   6 0 )   ;             / /   i n   m i n u t e  
             n B a r s   =   ( i n t )   M a t h F l o o r ( d u r a t i o n   /   P e r i o d ( ) )   ;  
             / / i f ( I S _ E N A B L E _ L O G )   P r i n t ( "   D i s t a n c e B a r _ C a n d l e _ D i v e r g e n c e   F u n c t i o n   :   "   ,   d t C a n d l e   ,     "   "   ,   d t D i v e r g e n c e   ,   "   "   ,   n B a r s ) ;  
  
       }  
       r e t u r n   n B a r s ;  
   } 