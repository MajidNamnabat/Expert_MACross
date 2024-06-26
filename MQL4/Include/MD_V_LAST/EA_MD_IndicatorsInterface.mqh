/ / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |                                                                         E A _ H F _ I n d i c a t o r s I n t e r f a c e . m q h   |  
 / / |                                                                                                     M a j i d   N a m a n a b a t   |  
 / / |                                                                                                 m a j . n a m @ g m a i l . c o m   |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 # p r o p e r t y   c o p y r i g h t   " M a j i d   N a m a n a b a t "  
 # p r o p e r t y   l i n k             " m a j . n a m @ g m a i l . c o m "  
 # p r o p e r t y   s t r i c t  
 # i n c l u d e   < M D _ V _ L A S T \ \ E A _ C a n d l e s t i c k t y p e . m q h >  
 # i n c l u d e   < M D _ V _ L A S T \ \ E A _ C a n d l e S t i c k P a t t e r n s . m q h >  
 # i n c l u d e   < M D _ V _ L A S T \ \ E A _ M D _ M A C D _ D i v . m q h >  
 # i n c l u d e   < M D _ V _ L A S T \ \ E A _ M D _ M A C r o s s D i s . m q h >  
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
 e n u m   E N U M _ H T _ C L O S E P R I C E _ S T A T U S  
 {  
       E N U M _ H T _ S T A T U S _ U N K N O W N   =   0   ,  
       E N U M _ H T _ T R E N D _ B U L L I S H   =   1 ,  
       E N U M _ H T _ T R E N D _ B E A R I S H   =   - 1 ,  
       E N U M _ H T _ T R E N D _ B U L L I S H _ C R O S S   =   2   ,  
       E N U M _ H T _ T R E N D _ B E A R I S H _ C R O S S   =   - 2 ,  
       E N U M _ H T _ T R E N D _ B U L L I S H _ C R O S S _ D O W N C H A N N E L   =   4   ,  
       E N U M _ H T _ T R E N D _ B E A R I S H _ C R O S S _ U P C H A N N E L   =   - 4 ,  
       E N U M _ H T _ T R E N D _ B U L L I S H _ T O U C H _ U P C H A N N E L   =   8   ,  
       E N U M _ H T _ T R E N D _ B E A R I S H _ T O U C H _ D O W N C H A N N E L   =   - 8   ,  
       E N U M _ H T _ B U L L I S H _ O U T _ U P C H A N N E L   =   1 6   ,    
       E N U M _ H T _ B E A R I S H _ O U T _ D O W N C H A N N E L   =   - 1 6   ,    
 } ;  
  
 / / I n   B a s e   I   p r e f e r   s t a t i c   c l a s s   ,   b u t   D i s t a n c e   i s   a   c l a s s   s t o r e   v a l u e s   ,  
 c l a s s   C I n d i c a t o r s I n t e r f a c e  
     {  
 p r i v a t e :  
       s t r i n g                         m _ s t r S y m b o l ;  
       i n t                               m _ n T i m e F r a m e ;  
  
 p u b l i c :  
                                           C I n d i c a t o r s I n t e r f a c e ( ) ;  
                                         ~ C I n d i c a t o r s I n t e r f a c e ( ) ;  
       C S i g n a l C r o s s M V _ D i s   m _ o M V C r o s s D i s   ;  
  
       v o i d                             S e t u p ( s t r i n g   s t r S y m b o l ,   i n t   n T i m e F r a m e ,  
                                                       E N U M _ N O R M A L _ M V   n F a s t M V P e r i o d ,   E N U M _ M A _ M E T H O D   n F a s t M V T y p e ,  
                                                       E N U M _ N O R M A L _ M V   n S l o w M V P e r i o d ,   E N U M _ M A _ M E T H O D   n S l o w M V T y p e   ,    
                                                       E N U M _ C U S T O M _ A P P L I E D _ P R I C E   n A c t i v e C l o s e O r d e r C u r r e n t C a n d l e ) ;  
       d o u b l e                         G e t _ R S I ( i n t   n S h i f t ,   i n t   n R S I P e r i o d , E N U M _ A P P L I E D _ P R I C E   n A p p i e d P r i c e ) ;  
       E N U M _ W A V E _ T R E N D   G o l d e n D e a t h C r o s s S t a t u s ( i n t   n T i m e F r a m e ) ;  
       E N U M _ W A V E _ T R E N D   H i g h e r T i m e F r a m e T r e n d D e t e r m i n e ( i n t   n H i g h e r P e r i o d ) ;  
       E N U M _ W A V E _ T R E N D   W e e k l y T r e n d D e t e r m i n e ( ) ;  
       b o o l   I s I n R S I S a t u r a t i o n _ U s i n g _ D i v e r g e n c e ( i n t   n C o m m a n d ) ;  
       b o o l   A c t i v a t e _ T r a i l i n g S t o p ( i n t   n C o m m a n d ) ;  
       d o u b l e   P a r a b o l i c S A R ( d o u b l e   s a r s t e p = 0 . 0 2 , d o u b l e   s a r m a x i m u m = 0 . 2 ,   i n t   n S h i f t   =   1 ) ;  
       d o u b l e                         G e t _ H a l f T r e n d _ B u f ( i n t   n S h i f t ,   i n t   n A m p l i t u d e , i n t   n C h a n n e l D e v i a t i o n , b o o l   b S h o w A r r o w s , b o o l   b S h o w C h a n n e l s ,   i n t   n B u f f e r   =   0 ) ;  
       d o u b l e       G e t D L B C u s t o m ( i n t   n D T P e r i o d   =   1   ,   i n t   n D T P e r i o d 2   =   2   ,   i n t   n L e v e l U p   =   7 5   ,   i n t   n L e v e l D o w n   =   2 5 ,     i n t   n C o m m a n d   =   O P _ B U Y ,   i n t   n S h i f t   =   0 ) ;  
 d o u b l e   G e t A T R ( i n t   p e r i o d   ,   i n t   s h i f t ) ;  
     } ;  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |                                                                                                                                     |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 C I n d i c a t o r s I n t e r f a c e : : C I n d i c a t o r s I n t e r f a c e ( )  
     {  
       m _ s t r S y m b o l   =   " " ;  
       m _ n T i m e F r a m e   =   0 ;  
     }  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |                                                                                                                                     |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 C I n d i c a t o r s I n t e r f a c e : : ~ C I n d i c a t o r s I n t e r f a c e ( )  
     {  
     }  
  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |                                                                                                                                     |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 v o i d   C I n d i c a t o r s I n t e r f a c e : : S e t u p ( s t r i n g   s t r S y m b o l ,   i n t   n T i m e F r a m e ,  
                                                                   E N U M _ N O R M A L _ M V   n F a s t M V P e r i o d ,   E N U M _ M A _ M E T H O D   n F a s t M V T y p e ,  
                                                                   E N U M _ N O R M A L _ M V   n S l o w M V P e r i o d ,   E N U M _ M A _ M E T H O D   n S l o w M V T y p e   ,    
                                                                   E N U M _ C U S T O M _ A P P L I E D _ P R I C E   n A c t i v e C l o s e O r d e r C u r r e n t C a n d l e )  
     {  
       m _ s t r S y m b o l   =   s t r S y m b o l ;  
       m _ n T i m e F r a m e   =   n T i m e F r a m e   ;  
       m _ o M V C r o s s D i s . S e t u p ( m _ s t r S y m b o l , m _ n T i m e F r a m e ) ;  
       m _ o M V C r o s s D i s . S e t F a s t M V ( n F a s t M V P e r i o d ,   n F a s t M V T y p e ) ;  
       m _ o M V C r o s s D i s . S e t S l o w M V ( n S l o w M V P e r i o d ,   n S l o w M V T y p e ) ;  
       m _ o M V C r o s s D i s . S e t C a n d l e A p p l i e d ( n A c t i v e C l o s e O r d e r C u r r e n t C a n d l e ) ;  
             i f ( I S _ E N A B L E _ L O G )  
                   P r i n t ( " C I n d i c a t o r s I n t e r f a c e : : S e t u p " ) ;  
     }  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |                                                                                                                                     |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |                                                                                                                                     |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 d o u b l e   C I n d i c a t o r s I n t e r f a c e : : G e t _ R S I ( i n t   n S h i f t ,   i n t   n R S I P e r i o d , E N U M _ A P P L I E D _ P R I C E   n A p p i e d P r i c e )  
     {  
       d o u b l e   f R e s u l t   =   i R S I ( m _ s t r S y m b o l ,   m _ n T i m e F r a m e ,   n R S I P e r i o d ,   n A p p i e d P r i c e ,   n S h i f t )   ;  
       r e t u r n   f R e s u l t ;  
     }  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / G o l d e n   C r o s s   f u n c t i o n  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 E N U M _ W A V E _ T R E N D   C I n d i c a t o r s I n t e r f a c e : : G o l d e n D e a t h C r o s s S t a t u s ( i n t   n T i m e F r a m e )  
     {  
       d o u b l e   f m v p = i M A ( m _ s t r S y m b o l , n T i m e F r a m e , 5 0 , 0 , M O D E _ E M A , P R I C E _ C L O S E , 1 ) ;   / / I f   t h i s   i s   n o t   i n   u s e   i t s   f o r   f u t u r e   u s e  
  
       d o u b l e   s m v p = i M A ( m _ s t r S y m b o l , n T i m e F r a m e , 2 0 0 , 0 , M O D E _ S M A , P R I C E _ C L O S E , 1 ) ;   / / I f   t h i s   i s   n o t   i n   u s e   i t s   f o r   f u t u r e   u s e  
       E N U M _ W A V E _ T R E N D   T r e n d D i r e c t i o n   =   E N U M _ T R E N D _ U N K N O W N ;  
       i f ( f m v p   >   s m v p   & &   s m v p   >   0 . f )       / /   G o l d e n   C r o s s  
             T r e n d D i r e c t i o n   =   E N U M _ T R E N D _ B U L L I S H ;  
       e l s e  
             i f ( f m v p   <   s m v p   & &   s m v p   >   0 . f )         / / D e a t h   C r o s s  
                   T r e n d D i r e c t i o n   =   E N U M _ T R E N D _ B E A R I S H ;  
       i f ( T r e n d D i r e c t i o n   = =   E N U M _ T R E N D _ U N K N O W N   & &   f m v p   >   0 . f   & &   s m v p   >   0 . f )  
           {  
             i f ( I S _ E N A B L E _ L O G )  
                   P r i n t ( " G o l d e n D e a t h C r o s s S t a t u s   T r e n d D i r e c t i o n   = =   E N U M _ T R E N D _ U N K N O W N " ) ;  
           }  
 / / i f ( I S _ E N A B L E _ L O G )   P r i n t ( " G o l d e n D e a t h C r o s s S t a t u s   : :   f m v p   "   ,   f m v p   , "   s m v p   :   "   ,   s m v p   ,   "   "   ,   E n u m T o S t r i n g ( T r e n d D i r e c t i o n )   ) ;  
  
       r e t u r n   T r e n d D i r e c t i o n ;  
  
       / *  
             s w i t c h ( T i m e F r a m e )  
             {  
               c a s e   P E R I O D _ M N 1 :   s T i m e F r a m e   =   " M N 1   " ; b r e a k ;  
               c a s e   P E R I O D _ W 1 :     s T i m e F r a m e   =   " W 1   " ;   b r e a k ;  
               c a s e   P E R I O D _ D 1 :     s T i m e F r a m e   =   " D 1   " ;   b r e a k ;  
               c a s e   P E R I O D _ H 4 :     s T i m e F r a m e   =   " H 4   " ;   b r e a k ;  
               c a s e   P E R I O D _ H 1 :     s T i m e F r a m e   =   " H 1   " ;   b r e a k ;  
               c a s e   P E R I O D _ M 3 0 :   s T i m e F r a m e   =   " M 3 0   " ; b r e a k ;  
               c a s e   P E R I O D _ M 1 5 :   s T i m e F r a m e   =   " M 1 5   " ; b r e a k ;  
               c a s e   P E R I O D _ M 5 :     s T i m e F r a m e   =   " M 5   " ;   b r e a k ;  
               c a s e   P E R I O D _ M 1 :     s T i m e F r a m e   =   " M 1   " ;   b r e a k ;  
               d e f a u l t :                   s T i m e F r a m e   =   " " ;         b r e a k ;  
             }  
       * /  
       / *  
       i n t   T e s t ( )  
       {  
       }  
       * /  
  
     }  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / H i g h e r   T i m e F r a m e   U s i n g   t o   T r e n d   D e t e r m i n e   f u n c t i o n  
 / /   m o t   s h o w i n g   i n   o p t i m i z e d   s o   a s a n t a r   k a r d a m  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 E N U M _ W A V E _ T R E N D   C I n d i c a t o r s I n t e r f a c e : : H i g h e r T i m e F r a m e T r e n d D e t e r m i n e ( i n t   n H i g h e r P e r i o d )  
     {  
       b o o l   b T h i r d M V   =   f a l s e ;  
       E N U M _ W A V E _ T R E N D   T r e n d D i r e c t i o n   =   E N U M _ T R E N D _ U N K N O W N ;  
       d o u b l e   l s m v p   =   0 . f ;  
       d o u b l e   f m v p = i M A ( m _ s t r S y m b o l , n H i g h e r P e r i o d , m _ n H i g h e r T i m e F r a m e _ F a s t M V , 0 , M O D E _ E M A , P R I C E _ C L O S E , 1 ) ;   / / I f   t h i s   i s   n o t   i n   u s e   i t s   f o r   f u t u r e   u s e   / / 7  
       d o u b l e   s m v p = i M A ( m _ s t r S y m b o l , n H i g h e r P e r i o d , m _ n H i g h e r T i m e F r a m e _ S l o w M V , 0 , M O D E _ S M A , P R I C E _ C L O S E , 1 ) ;   / / I f   t h i s   i s   n o t   i n   u s e   i t s   f o r   f u t u r e   u s e   / / 2 1  
       / *  
       n o t   a s n w e r e d  
       d o u b l e   f m v p = i M A ( N U L L , n H i g h e r P e r i o d , 7 , 0 , M O D E _ E M A , P R I C E _ M E D I A N , 0 ) ;   / / I f   t h i s   i s   n o t   i n   u s e   i t s   f o r   f u t u r e   u s e   / / 7  
       d o u b l e   s m v p = i M A ( N U L L , n H i g h e r P e r i o d , 2 1 , 0 , M O D E _ S M A , P R I C E _ M E D I A N , 0 ) ;   / / I f   t h i s   i s   n o t   i n   u s e   i t s   f o r   f u t u r e   u s e   / / 2 1  
       * /  
       i f ( b T h i r d M V )  
           {  
             l s m v p = i M A ( m _ s t r S y m b o l , n H i g h e r P e r i o d , 3 4 , 0 , M O D E _ S M M A , P R I C E _ C L O S E , 1 ) ;   / / I f   t h i s   i s   n o t   i n   u s e   i t s   f o r   f u t u r e   u s e  
           }  
 / / P r i n t   ( " H i g h e r T i m e F r a m e T r e n d D e t e r m i n e   "   ,   f m v p   ,   "   "   ,   s m v p   ) ;  
       i f ( f m v p > s m v p   & &   ( s m v p > l s m v p   | |   ! b T h i r d M V ) )  
           {  
             T r e n d D i r e c t i o n   =   E N U M _ T R E N D _ B U L L I S H ;  
           }  
       e l s e  
             i f ( ( l s m v p < s m v p   | |   ! b T h i r d M V )   & &   f m v p < s m v p )  
                 {  
                   T r e n d D i r e c t i o n   =   E N U M _ T R E N D _ B E A R I S H ;  
                 }  
       i f ( T r e n d D i r e c t i o n   = =   E N U M _ T R E N D _ U N K N O W N   & &   f m v p   >   0   & &   s m v p   >   0 )  
           {  
             i f ( I S _ E N A B L E _ L O G )  
                   P r i n t ( " H i g h e r T i m e F r a m e T r e n d D e t e r m i n e   : :   T r e n d D i r e c t i o n   = =   E N U M _ T R E N D _ U N K N O W N   " ) ;  
           }  
       r e t u r n   T r e n d D i r e c t i o n ;  
     }  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |                                                                                                                                     |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 b o o l   C I n d i c a t o r s I n t e r f a c e : : I s I n R S I S a t u r a t i o n _ U s i n g _ D i v e r g e n c e ( i n t   n C o m m a n d )  
     {  
       P r i n t   ( " I s I n R S I S a t u r a t i o n _ U s i n g _ D i v e r g e n c e   "   ,   m _ n T r a i l i n g S t o p _ R S I _ O v e r B o u g h t L e v e l   ,   "   "   ,   m _ n T r a i l i n g S t o p _ R S I _ O v e r S o l d L e v e l ) ;  
       d o u b l e   r s i V a l u e   =   i R S I ( m _ s t r S y m b o l , m _ n T i m e F r a m e , 1 4 , P R I C E _ C L O S E , 1 ) ;  
  
       i f ( n C o m m a n d   = =   O P _ B U Y   & &   r s i V a l u e   <   m _ n D i v e r g e n c e S t a t u r a t i o n _ R S I _ O v e r B o u g h t L e v e l )  
             r e t u r n   f a l s e ;  
       i f ( n C o m m a n d   = =   O P _ S E L L   & &   r s i V a l u e   >   m _ n D i v e r g e n c e S t a t u r a t i o n _ R S I _ O v e r S o l d L e v e l )  
             r e t u r n   f a l s e ;  
       r e t u r n   t r u e ;  
     }  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |   i f   c a n d l e   i s   g r e e n                                                                                                                               |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
       E N U M _ W A V E _ T R E N D   C I n d i c a t o r s I n t e r f a c e : : W e e k l y T r e n d D e t e r m i n e ( )  
       {  
             i n t   n W e e k P e r i o d   =   1 4 4 0 * 7 ;  
             E N U M _ W A V E _ T R E N D   n T r e n d D i r e c t i o n   =   E N U M _ T R E N D _ U N K N O W N ;  
             i f ( i C l o s e ( m _ s t r S y m b o l , n W e e k P e r i o d , 0 ) > 0   & &   i C l o s e ( m _ s t r S y m b o l , n W e e k P e r i o d , 0 )   >   i O p e n ( m _ s t r S y m b o l , n W e e k P e r i o d , 0 ) )  
             {  
                   n T r e n d D i r e c t i o n   =   E N U M _ T R E N D _ B U L L I S H ;  
             }  
             e l s e   i f ( i C l o s e ( m _ s t r S y m b o l , n W e e k P e r i o d , 0 ) > 0 )  
             {  
                   n T r e n d D i r e c t i o n   =   E N U M _ T R E N D _ B E A R I S H ;  
             }                
             r e t u r n   n T r e n d D i r e c t i o n ;  
       }  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 b o o l   C I n d i c a t o r s I n t e r f a c e : : A c t i v a t e _ T r a i l i n g S t o p ( i n t   n C o m m a n d )  
     {  
 / / r e t u r n   f a l s e ;  
       i f ( P r o f i t T o T r a i l i n g S t o p   ! =   E N U M _ T R A I L I N G _ S T O P _ R S I _ S A T U R A T I O N )  
             r e t u r n   t r u e ;  
       i f ( P r o f i t T o T r a i l i n g S t o p   = =   E N U M _ T R A I L I N G _ S T O P _ R S I _ S A T U R A T I O N )  
           {  
             / /   c u r r e n t   r s i   u s d e   n o t   p r e v i o u s   c a n d l e   ,   -1�'*  F'�G'F�  ,   s u d d e n   m o v e m e n t  
             / /   c h e c k   p r e v i o u s   c a n d l e   i s   b e t t e r   l e s s   d r a w d o w n   m o r e   p r o f i t  
             d o u b l e   r s i V a l u e   =   i R S I ( m _ s t r S y m b o l , m _ n T i m e F r a m e , 1 4 , P R I C E _ C L O S E , 1 ) ;  
             i f ( n C o m m a n d   = =   O P _ B U Y   & &   r s i V a l u e   > =   m _ n T r a i l i n g S t o p _ R S I _ O v e r B o u g h t L e v e l )  
                   r e t u r n   t r u e ;  
             i f ( n C o m m a n d   = =   O P _ S E L L   & &   r s i V a l u e   < =   m _ n T r a i l i n g S t o p _ R S I _ O v e r S o l d L e v e l )  
                   r e t u r n   t r u e ;  
             r e t u r n   f a l s e ;  
           }  
  
       r e t u r n   f a l s e ;  
     }  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |                                                                                                                                     |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 d o u b l e   C I n d i c a t o r s I n t e r f a c e : : G e t _ H a l f T r e n d _ B u f ( i n t   n S h i f t ,   i n t   n A m p l i t u d e , i n t   n C h a n n e l D e v i a t i o n , b o o l   b S h o w A r r o w s , b o o l   b S h o w C h a n n e l s ,   i n t   n B u f f e r   =   0 )  
     {  
       d o u b l e   f R e s u l t   =   i C u s t o m ( m _ s t r S y m b o l , m _ n T i m e F r a m e , " H a l f T r e n d _ V 4 " , n A m p l i t u d e , n C h a n n e l D e v i a t i o n , b S h o w A r r o w s , b S h o w C h a n n e l s , n B u f f e r , n S h i f t ) ;  
       r e t u r n   f R e s u l t ;  
       r e t u r n   0 . 0 ;  
     }  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |                                                                                                                                     |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 d o u b l e   C I n d i c a t o r s I n t e r f a c e : : P a r a b o l i c S A R ( d o u b l e   s a r s t e p = 0 . 0 2 , d o u b l e   s a r m a x i m u m = 0 . 2 ,   i n t   n S h i f t   =   1 )  
 {  
       d o u b l e   f P a r a b o l i c V a l u e   =   i S A R ( m _ s t r S y m b o l , m _ n T i m e F r a m e , s a r s t e p , s a r m a x i m u m , n S h i f t ) ;  
       r e t u r n   f P a r a b o l i c V a l u e ;  
 }  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |                                                                                                                                     |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 d o u b l e       C I n d i c a t o r s I n t e r f a c e : : G e t D L B C u s t o m ( i n t   n D T P e r i o d   =   1   ,   i n t   n D T P e r i o d 2   =   2   ,   i n t   n L e v e l U p   =   7 5   ,   i n t   n L e v e l D o w n   =   2 5 ,   i n t   n C o m m a n d   =   O P _ B U Y   ,   i n t   n S h i f t   =   0 )  
 {  
       i n t   n B u f f e r   =   ( n C o m m a n d   = =   O P _ B U Y   | |   n C o m m a n d   = =   O P _ B U Y L I M I T   | |   n C o m m a n d   = =   O P _ B U Y S T O P )   ?   0   :   3   ;  
       d o u b l e   f R e s u l t   =   i C u s t o m ( m _ s t r S y m b o l , m _ n T i m e F r a m e , " D L B C u s t o m " , n D T P e r i o d , n D T P e r i o d 2 , n L e v e l U p , n L e v e l D o w n , n B u f f e r , n S h i f t ) ;  
       r e t u r n   f R e s u l t ;  
        
 }  
 d o u b l e   C I n d i c a t o r s I n t e r f a c e : : G e t A T R ( i n t   p e r i o d   ,   i n t   s h i f t )  
 {  
       / / P r i n t ( " G e t A T R   "   , m _ s t r S y m b o l   ,   "   "   ,   m _ n T i m e F r a m e   ,   "   "   ,     p e r i o d   ,   "   "   ,   s h i f t ) ;  
       d o u b l e   f R e s u l t   =   i A T R ( m _ s t r S y m b o l , m _ n T i m e F r a m e , p e r i o d , s h i f t ) ;  
       r e t u r n   f R e s u l t ;  
 } 