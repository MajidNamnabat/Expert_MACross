/ / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |                                                                                                     E A _ P r o f i l e s . m q h   |  
 / / |                                                                                                     M a j i d   N a m a n a b a t   |  
 / / |                                                                                                 m a j . n a m @ g m a i l . c o m   |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 # p r o p e r t y   c o p y r i g h t   " M a j i d   N a m a n a b a t "  
 # p r o p e r t y   l i n k             " m a j . n a m @ g m a i l . c o m "  
 # p r o p e r t y   s t r i c t  
 # i n c l u d e   < M D _ V _ L A S T \ \ E A _ M D _ T y p e s . m q h >  
 # i n c l u d e   < M D _ V _ L A S T \ \ E A _ M D _ P a r a m e t e r s . m q h >  
 # i n c l u d e   < M D _ V _ L A S T \ \ E A _ M D _ U t i l i t y F u n c t i o n s . m q h >  
 # i n c l u d e   < M D _ V _ L A S T \ \ E A _ M D _ O p t i m i z a t i o n T e s t . m q h >  
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
 c l a s s   C E A P r o f i l e  
     {  
 p r o t e c t e d :  
       / / - - -   i n p u t   p a r a m e t e r s  
 p u b l i c :  
                                           C E A P r o f i l e ( v o i d ) ;  
                                         ~ C E A P r o f i l e ( v o i d ) ;  
       v o i d                             C o p y O r i g i n a l P a r a m e t e r s ( ) ;  
       v o i d                             L o a d _ O p t i m i z a t i o n _ D e t a i l O r d e r _ L e v e l 4 _ 2 ( ) ;  
       v o i d                             L o a d _ O p t i m i z a t i o n _ D e t a i l O r d e r _ L e v e l 4 ( ) ;  
       v o i d                             L o a d _ O p t i m i z a t i o n _ C l o s e O r d e r _ L e v e l 3 ( ) ;  
       v o i d                             L o a d _ O p t i m i z a t i o n _ O p e n O r d e r _ L e v e l 1 ( ) ;  
       v o i d                             L o a d _ G B P U S D _ 6 0 ( ) ;  
       v o i d                             L o a d _ G B P U S D _ 1 5 ( ) ;  
       v o i d                             L o a d _ U S D J P Y _ 1 5 ( ) ;  
       v o i d                             L o a d _ A U D U S D _ 1 5 ( ) ;  
       v o i d                             L o a d _ E U R U S D _ 6 0 ( ) ;  
       v o i d                             L o a d _ E U R U S D _ 1 5 ( ) ;  
       v o i d                             L o a d _ X A U U S D _ 1 5 ( ) ;  
       v o i d                             L o a d _ U S D C A D _ 1 5 ( ) ;  
       v o i d                             L o a d _ S t a n d a r d ( ) ;  
       v o i d                             L o a d _ X A G U S D _ 1 5 ( ) ;  
  
       v o i d                             L o a d P r o f i l e ( s t r i n g   s t r S y m b o l ,   i n t   n T i m e F r a m e ) ;  
       v o i d                             L o a d T e s t P a r a m e t e r s ( ) ;  
       v o i d                             L o a d S p e c i a l S y m b o l _ P a r a m e t e r s ( s t r i n g   s t r S y m b o l ,   i n t   n T i m e F r a m e ) ;  
     } ;  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |                                                                                                                                     |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 C E A P r o f i l e : : C E A P r o f i l e ( v o i d )  
     {  
     }  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |                                                                                                                                     |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 C E A P r o f i l e : : ~ C E A P r o f i l e ( v o i d )  
     {  
     }  
  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |                                                                                                                                     |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 v o i d   C E A P r o f i l e : : C o p y O r i g i n a l P a r a m e t e r s ( )  
     {  
 / /   S e t   P r o p e r t y   V a l u e s   A t   f i r s t  
       F a s t M V P e r i o d = p r F a s t M V P e r i o d ;  
       S l o w M V P e r i o d = p r S l o w M V P e r i o d ;  
       F a s t M V T y p e = p r F a s t M V T y p e ;  
       S l o w M V T y p e = p r S l o w M V T y p e ;  
       M V s M i n O p e n D i s t a n c e = p r M V s M i n O p e n D i s t a n c e ;  
       M V s M a x C l o s e D i s t a n c e = p r M V s M a x C l o s e D i s t a n c e ;  
       A c t i v e C l o s e O r d e r C u r r e n t C a n d l e   =   p r A c t i v e C l o s e O r d e r C u r r e n t C a n d l e   ;  
       O r d e r A s T r e n d   =   p r O r d e r A s T r e n d   ;  
       T r a i l i n g S t o p M e t h o d                             =   p r T r a i l i n g S t o p M e t h o d   ;  
  
       P a t i e n t T i m e       =   p r P a t i e n t T i m e ;  
       B a l a n c e R i s k V o l u m e = p r B a l a n c e R i s k V o l u m e ;  
       M a n u a l T a k e P r o f i t = p r M a n u a l T a k e P r o f i t ;  
       m _ n S t o p L o s s P a r a m e t e r = p r S t o p L o s s P a r a m e t e r ;  
       m _ n T i m e L i m i t _ S t o p L o s s   =   p _ n T i m e L i m i t _ S t o p L o s s ;  
  
       A c t i v e B r e a k E v e n D i s t a n c e                               =   p r A c t i v e B r e a k E v e n D i s t a n c e ;  
       B r e a k E v e n P o i n t                                     =   p r B r e a k E v e n P o i n t ;  
       m _ n T a k e P r o f i t M e t h o d                       =   p _ n T a k e P r o f i t M e t h o d ;  
       P r o f i t T o T r a i l i n g S t o p                               =   p r P r o f i t T o T r a i l i n g S t o p ;  
       T r a i l i n g P a r a m e t e r       =   p r T r a i l i n g P a r a m e t e r   ;  
       m _ n S t o p L o s s T y p e   =   p r S t o p L o s s T y p e   ;  
       m _ n I s _ E x i t S i g n a l _ N o n M V M e t h o d   =   p r I s _ E x i t S i g n a l _ N o n M V M e t h o d ;  
       m _ n A c t i v e S t a i r T r a d i n g M a n a g e m e n t   =   p r A c t i v e S t a i r T r a d i n g M a n a g e m e n t ;  
       / * A T R P e r i o d   =   p r A T R P e r i o d   ;  
       T r a i l i n g S t o p F i x e d P o i n t   =   p r T r a i l i n g S t o p F i x e d P o i n t   ;  
       T r a i l S t o p M V P e r i o d   =   p r T r a i l S t o p M V P e r i o d ; * /  
       m _ n L o t M a n a g e m e n t M e t h o d   =   p r L o t M a n a g e m e n t M e t h o d   ;  
       m _ n S i g n a l M A C D P e r i o d   =   p r S i g n a l M A C D P e r i o d   ;  
       m _ n H o u r s R e s t _ W h e n B i g L o s s   =   p r H o u r s R e s t _ W h e n B i g L o s s   ;  
       m _ n I n i t O r d e r S e t R u l e   =   p r I n i t O r d e r S e t R u l e   ;  
       m _ n B i g S t o p _ F i x e d L o t   =   p r B i g S t o p _ F i x e d L o t ;  
       m _ f L o s s _ R i s k B a l a n c e _ R a t i o _ R e s t   =   p _ f L o s s _ R i s k B a l a n c e _ R a t i o _ R e s t ;  
       m _ n T i m e T r a d e M a n a g e r   =   p r T i m e T r a d e M a n a g e r ;  
       m _ n O p e n O r d e r _ R i s k A n a l y s i s   =   p _ n O p e n O r d e r _ R i s k A n a l y s i s ;  
       i f ( m _ n O p e n O r d e r _ R i s k A n a l y s i s   = =   E N U M _ O P E N O R D E R _ R I S K A N A L Y S I S _ D L B _ B A S E D )  
           {  
             m _ n O p e n O r d e r _ R i s k A n a l y s i s _ D L B U p   = p _ n O p e n O r d e r _ R i s k A n a l y s i s _ L e v e l U p ;  
             m _ n O p e n O r d e r _ R i s k A n a l y s i s _ D L B D o w n = p _ n O p e n O r d e r _ R i s k A n a l y s i s _ L e v e l D o w n ;  
           }  
       e l s e  
           {  
             m _ n O p e n O r d e r _ R i s k A n a l y s i s _ R S I U p   = p _ n O p e n O r d e r _ R i s k A n a l y s i s _ L e v e l U p ;  
             m _ n O p e n O r d e r _ R i s k A n a l y s i s _ R S I D o w n = p _ n O p e n O r d e r _ R i s k A n a l y s i s _ L e v e l D o w n ;  
           }  
       m _ n O p e n O r d e r _ R i s k A n a l y s i s _ D L B P e r i o d 1 = p _ n O p e n O r d e r _ R i s k A n a l y s i s _ D L B P e r i o d 1 ;  
       m _ n O p e n O r d e r _ R i s k A n a l y s i s _ D L B P e r i o d 2 = p _ n O p e n O r d e r _ R i s k A n a l y s i s _ D L B P e r i o d 2 ;  
  
       m _ n H i g h e r T i m e F r a m e _ F a s t M V   =   p _ n H i g h e r T i m e F r a m e _ F a s t M V ;               / / O p t 9  
       m _ n H i g h e r T i m e F r a m e _ S l o w M V   =   p _ n H i g h e r T i m e F r a m e _ S l o w M V ;             / / O p t 9  
       m _ n T r a i l i n g S t o p _ R S I _ O v e r S o l d L e v e l   =   p _ n T r a i l i n g S t o p _ R S I _ O v e r S o l d L e v e l ;         / / O p t 1 0  
       m _ n T r a i l i n g S t o p _ R S I _ O v e r B o u g h t L e v e l   =   p _ n T r a i l i n g S t o p _ R S I _ O v e r B o u g h t L e v e l ;       / / O p t 1 0  
       m _ f S t d R a t i o   =   p _ f S t d R a t i o ;  
       m _ n M a x S l o p e _ 4 5 _ D i s t a n c e   =   p _ n M a x S l o p e _ 4 5 _ D i s t a n c e ;  
       m _ n M a x S l o p e _ S t o p _ D i s t a n c e   =   p _ n M a x S l o p e _ S t o p _ D i s t a n c e ;  
  
  
       b o o l   b S u c c e e d   =   S p l i t _ S t r i n g ( p _ s t r S y m b o l s _ L i s t , m _ S y m b o l s L i s t ) ;  
       b S u c c e e d   =   S p l i t _ I n t S t r i n g ( p _ s t r T i m e F r a m e s _ L i s t , m _ T i m e F r a m e s L i s t ) ;  
       i f ( M Q L I n f o I n t e g e r ( M Q L _ O P T I M I Z A T I O N )   | |   I s T e s t i n g ( ) )  
           {  
             P r i n t ( " m _ S y m b o l s L i s t   i s   C h a n g e d   t o   O n e   C e l l " ) ;  
             A r r a y F r e e ( m _ S y m b o l s L i s t ) ;  
             A r r a y R e s i z e ( m _ S y m b o l s L i s t , 1 ) ;  
             m _ S y m b o l s L i s t [ 0 ]   =   S y m b o l ( )   ;  
             A r r a y R e s i z e ( m _ T i m e F r a m e s L i s t , 1 ) ;  
             m _ T i m e F r a m e s L i s t [ 0 ]   =   P e r i o d ( )   ;  
           }  
     }  
  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |                                                                                                                                     |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 v o i d   C E A P r o f i l e : : L o a d _ X A U U S D _ 1 5 ( )  
     {  
       S l o w M V T y p e   =   M O D E _ S M A ;  
       A c t i v e C l o s e O r d e r C u r r e n t C a n d l e   =   P R E V I O U S _ C A N D L E   ;  
       m _ n L o t M a n a g e m e n t M e t h o d   =   E N U M _ L O T _ M A N A G E M E N T _ S L _ B E L O W _ S M V   ;  
       B r e a k E v e n P o i n t   =   3 5 ;   / /   i n   r o b o f o r e x   s p r e a d   i s   w i d e   2 5   p i p   ,   s o   B r e a k E v e n t   m u s t   h i g h e r  
       B a l a n c e R i s k V o l u m e   =   0 . 0 2 4 ; / / 0 . 0 1 8   i n   R i s k O p e n O r d e r   D i s a b l e   ;   / / S t a n d a r d   M o n e y   M a n a g e m e n t   i s   M a x i m u m   R i s k   2 . 5 %  
  
  
       S l o w M V P e r i o d   =   3 4 ;  
       F a s t M V P e r i o d   =   2 6 ;  
       F a s t M V T y p e   =   M O D E _ E M A ;  
       M V s M i n O p e n D i s t a n c e   =   3 1 5 ;                 / / O p t   D o n e  
  
  
       m _ n I n i t O r d e r S e t R u l e   =   E N U M _ I N I T O R D E R _ S E T _ A L L S P O T ;   / / O p t 6   D o n e  
  
       M V s M a x C l o s e D i s t a n c e   =   1 2 0   ;  
       A c t i v e B r e a k E v e n D i s t a n c e   =   E N U M _ B R E A K E V E N _ D I S A B L E D ; / / E N U M _ B R E A K E V E N _ I N T E L L I G E N T _ S T A T I S T I C S ; / / ;   / / E N U M _ B R E A K E V E N _ R _ R _ 1 0 0   ;   / / O p t 8  
       m _ n T a k e P r o f i t M e t h o d   =   E N U M _ T A K E P R O F I T _ D I S A B L E D ;  
       P r o f i t T o T r a i l i n g S t o p   =   E N U M _ T R A I L I N G _ S T O P _ R S I _ S A T U R A T I O N   ;   / / 8 0   ;   / / O p t 4   D o n e  
       T r a i l i n g S t o p M e t h o d   =   E N U M _ T R A I L I N G S T O P _ A T R ;   / / E N U M _ T R A I L I N G S T O P _ A T R 1 5   ;     / /   / / O p t 3   D o n e  
 / / C h a n g e   F r o m   1 3   T o   2 1   ,   P o s i t i v e   I   t h o u g h t  
       T r a i l i n g P a r a m e t e r   =   2 0 ;   / /   3 0 ;   / / O p t 3   D o n e  
       m _ n I s _ E x i t S i g n a l _ N o n M V M e t h o d   =   E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ D I S A B L E ; / / E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ C A N D L E S T I C K _ A N D _ D I V E R G E N C E ; / / E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ D I S A B L E ;   / / E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ O N L Y _ D I V E R G E N C E ;   / /   E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ O N L Y _ D I V E R G E N C E ;  
       m _ n S i g n a l M A C D P e r i o d   =   1 2   ;  
       m _ n S t o p L o s s T y p e   =   E N U M _ S T O P L O S S _ B E L O W _ C U S T O M _ M V _ U P D A T E B L E _ C L O S E _ B A S E D ;   / /   E N U M _ S T O P L O S S _ B E L O W _ S L O W _ M V ;   / / O p t 2   D o n e  
     m _ n S t o p L o s s P a r a m e t e r   =   2 6 ;   / / O p t 2   D o n e  
       m _ n O p e n O r d e r _ R i s k A n a l y s i s   =   E N U M _ O P E N O R D E R _ R I S K A N A L Y S I S _ D L B _ B A S E D ;  
       m _ n O p e n O r d e r _ R i s k A n a l y s i s _ D L B U p   =   9 4 ;  
       m _ n O p e n O r d e r _ R i s k A n a l y s i s _ D L B D o w n   =   1 6 ;  
       m _ n T i m e L i m i t _ S t o p L o s s   =   0 ;  
  
       O r d e r A s T r e n d   =   E N U M _ T R E N D _ H I G H E R _ T I M E F R A M E   ;   / / E N U M _ T R E N D _ D E T E R M I N E _ N O N E ; / /   E N U M _ T R E N D _ G O L D E N C R O S S   ;   / / O p t 5   D o n e  
 / / i n   r o b o f o r e x   i n   1   y e a r   d a t a   s o m e   c a n d l e s   i s   v e r y   h i g h   n a v a s a n   ,   i n   o n e   t r a d e   I   b e c o m e   c a l l   m a r g i n   ,   n o t   a c c e p t a b l e ,  
 / /   I n   o n e   e x p e r i e n c e   s o   n e a r   t o   s t o p   l o s s   o r d e r   o p e n   ,   s o   h u g e   l o t   ,   a n d   I   b e c o m e   c a l l   m a r g i n  
       P a t i e n t T i m e   =   H u r y U p ;  
 / / n o t   a n s w e r   R S I   a n d   ,   D I S A B L E   i s   s i m i l a r   t o   R S I _ C A N D L E S T I C K  
       m _ n A c t i v e S t a i r T r a d i n g M a n a g e m e n t   =     E N U M _ S T A I R T R A D I N G _ M A N A G E M E N T _ N O N E ;   / /   E N U M _ S T A I R T R A D I N G _ M A N A G E M E N T _ S T C _ C O M P E N S A T E   ;   / / E N U M _ S T A I R T R A D I N G _ M A N A G E M E N T _ S T C _ C O M P E N S A T E   ;   / / E N U M _ S T A I R T R A D I N G _ M A N A G E M E N T _ S T C _ C O M P E N S A T E ;  
       m _ n B i g S t o p _ F i x e d L o t   =   t r u e ;   / / O p t 1   D o n e  
       m _ n H o u r s R e s t _ W h e n B i g L o s s   =   3 6 ;   / /   A d v i s e   a l l   M o n e y   M a n a g e m e n t   S y s t e m s   / / O p t   D o n e  
       m _ f L o s s _ R i s k B a l a n c e _ R a t i o _ R e s t   =   1 . 2 5 ;   / / O p t   D o n e  
  
       m _ n T i m e T r a d e M a n a g e r   =   E N U M _ T I M E _ T R A D E _ F R I D A Y _ A L L _ N O T _ O P E N   ;   / /   E N U M _ T I M E _ T R A D E _ H O L I D A Y _ O F F S E T   ;   / / O p t 7   D o n e  
       m _ f S t a t _ P r o f i t _ A v g   =   9 2 8 . 6 ;  
       m _ f S t a t _ P r o f i t _ S t d   =   1 0 7 0 . 9 5 ;  
       m _ n B r e a k E v e n _ I n t e l l i g e n t _ P i p D i s t a n c e _ A c t i v a t i o n   =   3 ;  
  
       m _ n H i g h e r T i m e F r a m e _ F a s t M V   =   9 ;  
       m _ n H i g h e r T i m e F r a m e _ S l o w M V   =   2 1 ;  
       m _ n T r a i l i n g S t o p _ R S I _ O v e r S o l d L e v e l   =   2 0 ;  
       m _ n T r a i l i n g S t o p _ R S I _ O v e r B o u g h t L e v e l   =   8 0 ;  
      
       m _ n I s D o n e V a l i d a t o i n _ D u r i n g T e s t i n g   =   E N U M _ V A L I D A T I O N _ S T A T I S T I C S _ O N L Y ;  
     }  
  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |                                                                                                                                     |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 v o i d   C E A P r o f i l e : : L o a d _ E U R U S D _ 1 5 ( )  
     {  
       / *  
       3 0   ,   5 0   L W M A   1  
       / *   E U R U S D   1 5   I N   E X I T _ S I G N A L   P r o f i t   S o r t  
       9   2 6 , 5 0 , M O D E _ L W M A , 1 . 7   - 5 0  
       1 0   3 0 , 5 0 , M O D E _ L W M A , 1 . 5   - 1 5 0  
       3 0 , 5 0 , M O D E _ L W M A , 1 . 6  
       3 0 , 5 0 , M O D E _ E M A , 1 . 6  
       1 1   3 4 , 5 0 , M O D E _ L W M A , 1 . 4  
       1   1 3 , 3 0 , M O D E _ E M A , 1 . 4  
       3   9 , 3 4 , M O D E _ L W M A , 1 . 7  
       4   1 3 , 3 0 , M O D E _ L W M A , 1 . 8  
       4   1 3 , 3 0 , M O D E _ E M A , 1 . 8   ? ?  
       9   2 6 , 5 0 , M O D E _ E M A , 1 . 5  
       0   9 , 3 0 , M O D E _ L W M A , 1 . 8  
       7   1 3 , 5 0 , M O D E _ L W M A , 1 . 7  
       5   2 1 , 3 4 , M O D E _ L W M A , 1 . 6  
       8   2 1 , 5 0 , M O D E _ L W M A , 1 . 4  
       1 0   3 0 , 5 0 , M O D E _ L W M A , 1 . 4  
       3   9 , 3 4 , M O D E _ L W M A , 1 . 5  
       6   2 6 , 3 4 , M O D E _ E M A , 1 . 7  
       2   2 1 , 3 0 , M O D E _ E M A , 1 . 7  
       4   1 3 , 3 4 , M O D E _ E M A , 1 . 8  
  
       / / W i n R a t i o   S o r t   E x i t   S i g n a l  
       9 , L W M A  
       1 0 , E M A , 1 . 6  
       6 , E M A , 1 . 7   I n t e r 1  
       6 , E M A , 1 . 3   I n t e r 1  
       1 , E M A , 1 . 3  
       1 1 , L W M A , 1 . 4   I n t e r 2  
       9 , L W M A , 1 . 6   I n t e r t i n g  
       1 1 , L W M A   1 . 8   I n t e r 2  
       S o m e   o f   T h e m   i s   N e a r   a n d   C o n t i n u a t i o n   B o t h   W o r k     H a v e   D i s t a n c e   ,   S o m e   o f   T h e m  
       N o t   F i x e d   R u l e   C a n   E x t r a c t   R e a l l y  
        
       / / I n C l o s e   S o r t   P r o f i t  
       1 0 , 3 , 1 . 5  
       1 1 , 3 , 1 . 3  
       1 0 , 3 , 1 . 7  
       1 1 , 3 , 1 . 6  
       8 , 3 , 1 . 5  
       1 1 , 3 , 1 . 4  
       1 1 , 3 , 1 . 7  
       1 1 , 1 , 1 . 6  
       1 0 , 1 , 1 . 6  
       8 , 1 , 1 . 6  
       7 , 1 , 1 . 5  
       1 1 , 1 , 1 . 5  
       7 , 3 , 1 . 5  
       8 , 1 , 1 . 4  
       8 , 1 , 1 . 7  
       9 , 1 , 1 . 5  
        
       S o r t   W i n R a t i o  
       1 1 , 1 , 1 . 6 , 0 . 5 7  
       7 , 3 , 1 . 5 , 5 7  
       3 , 1 , 1 . 5 , 0 . 5 5  
       1 0 , 1 , 1 . 6 , 0 . 5 5  
       1 1 , 3 , 1 . 7 , 0 . 5 5  
       8 , 1 , 1 . 7 , 0 . 5 5  
        
       / / L a s t T e s t   E U R U S D   S t o p L o s s   T a k e P r o f i t  
       { 1 0 , M O D E _ E M A , 1 . 6 } , E N U M _ S T O P L O S S _ B E L O W _ C U S T O M _ M V _ C L O S E _ B A S E D , 3 4 , E N U M _ T A K E P R O F I T _ M M _ R _ H R   ,   - 7 4 $ ,   1 6 0 T r a d e , 1 2 . 9 % D D  
       { 1 0 , M O D E _ L W M A , 1 . 7 } ,  
       { 1 0 , M O D E _ L W M A , 1 . 5 } ,  
       { 1 0 , M O D E _ E M A , 1 . 6 } , E N U M _ S T O P L O S S _ B E L O W _ C U S T O M _ M V _ C L O S E _ B A S E D , 5 0 , E N U M _ T A K E P R O F I T _ M M _ R _ H R   ,   - 8 0 $ ,   1 5 8 T r a d e , 1 2 . 1 8 % D D  
       { 1 0 , M O D E _ L W M A , 1 . 7 } ,  
       { 1 0 , M O D E _ L W M A , 1 . 5 } ,  
  
       / / W i n R a t i o   S o r t  
       { 1 1 , M O D E _ L W M A , 1 . 7 } , E N U M _ T A K E P R O F I T _ M M _ R _ R , E N U M _ S T O P L O S S _ B E L O W _ C U S T O M _ M V _ U P D A T E B L E , 5 0   ,   6 1 . 2 %   W i n R a t i o   ,   2 1 8 %   L o s s   ,   1 4 2   T r a d e s   ,   2 1 . 5 % D D  
       P r o b l e m   i s   C l o s e   O b v i o u s l y  
       { 1 1 , M O D E _ E M A , 1 . 6 } ,  
       { 1 1 , M O D E _ L W M A , 1 . 6 } ,  
       { 1 1 , M O D E _ L W M A , 1 . 3 } ,  
       O b v .   T K _ R R   b e t t e r   T K _ H R _ R   a n d   B e t t e r   D I S A B L E D  
       O b v .     E N U M _ S T O P L O S S _ B E L O W _ C U S T O M _ M V _ U P D A T E B L E , 5 0   i s   b e s t   f o r   W i n R a t i o   H i g h e s t  
       O b v .    
       * /  
     / *  
     4 7 4 3 	 P r : 1 1 8 5 . 2 2 	 1 4 2 	 1 . 0 2 	 8 . 3 5 	 2 1 3 8 4 . 0 4 	 1 5 . 7 4 % 	 0 . 2 4 6 3 7 6 8 1 	 p r M V O p e n O r d e r O p t i m i z e S e r i e s = 1   	 p r M V s M a x C l o s e D i s t a n c e = 8 0   	 p r A c t i v e B r e a k E v e n D i s t a n c e = 2 0   	 p _ n T a k e P r o f i t M e t h o d = - 2   	 p r S t o p L o s s T y p e = 6   	 p r S t o p L o s s P a r a m e t e r = 3 0   	 p _ n H i g h e r T i m e F r a m e _ F a s t M V = 9   	 p _ n H i g h e r T i m e F r a m e _ S l o w M V = 2 1 	 p r O p t i m i s e d P r o f i l e L o a d = 1   	 p r F a s t M V P e r i o d = 2 1   	 p r S l o w M V P e r i o d = 3 4   	 p r M V s M i n O p e n D i s t a n c e = 2 7   	 p r O r d e r A s T r e n d = 1   	 p r T r a i l i n g C o m b i n a t i o n P a r a m e t e r = - 1   	 p r O p t T s t B r T r D i s O p t i m i z a t i o n S e r i e s = - 1   	 p r P a t i e n t T i m e = 1   	 p r A c t i v e C l o s e O r d e r C u r r e n t C a n d l e = 1   	 p r B r e a k E v e n P o i n t = 5   	 p r T r a i l i n g S t o p M e t h o d = 5   	 p r P r o f i t T o T r a i l i n g S t o p = 1 0 0   	 p r T r a i l i n g P a r a m e t e r = 2 0   	 p r F a s t M V T y p e = 1   	 p r S l o w M V T y p e = 0   	 p r B a l a n c e R i s k V o l u m e = 0 . 0 5   	 p r M a n u a l T a k e P r o f i t = 0   	 p _ n O p e n O r d e r _ R i s k A n a l y s i s = 2   	 p _ n O p e n O r d e r _ R i s k A n a l y s i s _ L e v e l U p = 9 0   	 p _ n O p e n O r d e r _ R i s k A n a l y s i s _ L e v e l D o w n =  
 { 1 0 , M O D E _ L W M A , 1 . 7 } ,  
 4 1 7 1 	 1 1 8 5 . 2 2 	 1 4 2 	 1 . 0 2 	 8 . 3 5 	 2 1 3 8 4 . 0 4 	 1 5 . 7 4 % 	 0 . 2 4 6 3 7 6 8 1 	 p r M V O p e n O r d e r O p t i m i z e S e r i e s = 1   	 p r M V s M a x C l o s e D i s t a n c e = 8 0   	 p r A c t i v e B r e a k E v e n D i s t a n c e = - 2   	 p _ n T a k e P r o f i t M e t h o d = - 2   	 p r S t o p L o s s T y p e = 4   	 p r S t o p L o s s P a r a m e t e r = 3 0   	 p _ n H i g h e r T i m e F r a m e _ F a s t M V = 9   	 p _ n H i g h e r T i m e F r a m e _ S l o w M V = 2 1 	 p r O p t i m i s e d P r o f i l e L o a d = 1   	 p r F a s t M V P e r i o d = 2 1   	 p r S l o w M V P e r i o d = 3 4   	 p r M V s M i n O p e n D i s t a n c e = 2 7   	 p r O r d e r A s T r e n d = 1   	 p r T r a i l i n g C o m b i n a t i o n P a r a m e t e r = - 1   	 p r O p t T s t B r T r D i s O p t i m i z a t i o n S e r i e s = - 1   	 p r P a t i e n t T i m e = 1   	 p r A c t i v e C l o s e O r d e r C u r r e n t C a n d l e = 1   	 p r B r e a k E v e n P o i n t = 5   	 p r T r a i l i n g S t o p M e t h o d = 5   	 p r P r o f i t T o T r a i l i n g S t o p = 1 0 0   	 p r T r a i l i n g P a r a m e t e r = 2 0   	 p r F a s t M V T y p e = 1   	 p r S l o w M V T y p e = 0   	 p r B a l a n c e R i s k V o l u m e = 0 . 0 5   	 p r M a n u a l T a k e P r o f i t = 0   	 p _ n O p e n O r d e r _ R i s k A n a l y s i s = 2   	 p _ n O p e n O r d e r _ R i s k A n a l y s i s _ L e v e l U p = 9 0   	 p _ n O p e n O r d e r _ R i s k A n a l y s i s _ L e v e l D o w n =  
 4 2 1 5 	 1 1 8 5 . 2 2 	 1 4 2 	 1 . 0 2 	 8 . 3 5 	 2 1 3 8 4 . 0 4 	 1 5 . 7 4 % 	 0 . 2 4 6 3 7 6 8 1 	 p r M V O p e n O r d e r O p t i m i z e S e r i e s = 1   	 p r M V s M a x C l o s e D i s t a n c e = 8 0   	 p r A c t i v e B r e a k E v e n D i s t a n c e = 2 0   	 p _ n T a k e P r o f i t M e t h o d = - 2   	 p r S t o p L o s s T y p e = 4   	 p r S t o p L o s s P a r a m e t e r = 3 0   	 p _ n H i g h e r T i m e F r a m e _ F a s t M V = 9   	 p _ n H i g h e r T i m e F r a m e _ S l o w M V = 2 1 	 p r O p t i m i s e d P r o f i l e L o a d = 1   	 p r F a s t M V P e r i o d = 2 1   	 p r S l o w M V P e r i o d = 3 4   	 p r M V s M i n O p e n D i s t a n c e = 2 7   	 p r O r d e r A s T r e n d = 1   	 p r T r a i l i n g C o m b i n a t i o n P a r a m e t e r = - 1   	 p r O p t T s t B r T r D i s O p t i m i z a t i o n S e r i e s = - 1   	 p r P a t i e n t T i m e = 1   	 p r A c t i v e C l o s e O r d e r C u r r e n t C a n d l e = 1   	 p r B r e a k E v e n P o i n t = 5   	 p r T r a i l i n g S t o p M e t h o d = 5   	 p r P r o f i t T o T r a i l i n g S t o p = 1 0 0   	 p r T r a i l i n g P a r a m e t e r = 2 0   	 p r F a s t M V T y p e = 1   	 p r S l o w M V T y p e = 0   	 p r B a l a n c e R i s k V o l u m e = 0 . 0 5   	 p r M a n u a l T a k e P r o f i t = 0   	 p _ n O p e n O r d e r _ R i s k A n a l y s i s = 2   	 p _ n O p e n O r d e r _ R i s k A n a l y s i s _ L e v e l U p = 9 0   	 p _ n O p e n O r d e r _ R i s k A n a l y s i s _ L e v e l D o w n =  
 4 6 9 9 	 1 1 8 5 . 2 2 	 1 4 2 	 1 . 0 2 	 8 . 3 5 	 2 1 3 8 4 . 0 4 	 1 5 . 7 4 % 	 0 . 2 4 6 3 7 6 8 1 	 p r M V O p e n O r d e r O p t i m i z e S e r i e s = 1   	 p r M V s M a x C l o s e D i s t a n c e = 8 0   	 p r A c t i v e B r e a k E v e n D i s t a n c e = - 2   	 p _ n T a k e P r o f i t M e t h o d = - 2   	 p r S t o p L o s s T y p e = 6   	 p r S t o p L o s s P a r a m e t e r = 3 0   	 p _ n H i g h e r T i m e F r a m e _ F a s t M V = 9   	 p _ n H i g h e r T i m e F r a m e _ S l o w M V = 2 1 	 p r O p t i m i s e d P r o f i l e L o a d = 1   	 p r F a s t M V P e r i o d = 2 1   	 p r S l o w M V P e r i o d = 3 4   	 p r M V s M i n O p e n D i s t a n c e = 2 7   	 p r O r d e r A s T r e n d = 1   	 p r T r a i l i n g C o m b i n a t i o n P a r a m e t e r = - 1   	 p r O p t T s t B r T r D i s O p t i m i z a t i o n S e r i e s = - 1   	 p r P a t i e n t T i m e = 1   	 p r A c t i v e C l o s e O r d e r C u r r e n t C a n d l e = 1   	 p r B r e a k E v e n P o i n t = 5   	 p r T r a i l i n g S t o p M e t h o d = 5   	 p r P r o f i t T o T r a i l i n g S t o p = 1 0 0   	 p r T r a i l i n g P a r a m e t e r = 2 0   	 p r F a s t M V T y p e = 1   	 p r S l o w M V T y p e = 0   	 p r B a l a n c e R i s k V o l u m e = 0 . 0 5   	 p r M a n u a l T a k e P r o f i t = 0   	 p _ n O p e n O r d e r _ R i s k A n a l y s i s = 2   	 p _ n O p e n O r d e r _ R i s k A n a l y s i s _ L e v e l U p = 9 0   	 p _ n O p e n O r d e r _ R i s k A n a l y s i s _ L e v e l D o w n =  
  
 5 2 7 1 	 1 5 7 5 . 5 4 	 1 4 3 	 1 . 0 3 	 1 1 . 0 2 	 1 8 4 9 2 . 3 4 	 1 3 . 8 6 % 	 0 . 1 7 1 8 7 5 0 0 	 p r M V O p e n O r d e r O p t i m i z e S e r i e s = 1   	 p r M V s M a x C l o s e D i s t a n c e = 8 0   	 p r A c t i v e B r e a k E v e n D i s t a n c e = 2 0   	 p _ n T a k e P r o f i t M e t h o d = - 2   	 p r S t o p L o s s T y p e = 5   	 p r S t o p L o s s P a r a m e t e r = 3 4   	 p _ n H i g h e r T i m e F r a m e _ F a s t M V = 9   	 p _ n H i g h e r T i m e F r a m e _ S l o w M V = 2 1 	 p r O p t i m i s e d P r o f i l e L o a d = 1   	 p r F a s t M V P e r i o d = 2 1   	 p r S l o w M V P e r i o d = 3 4   	 p r M V s M i n O p e n D i s t a n c e = 2 7   	 p r O r d e r A s T r e n d = 1   	 p r T r a i l i n g C o m b i n a t i o n P a r a m e t e r = - 1   	 p r O p t T s t B r T r D i s O p t i m i z a t i o n S e r i e s = - 1   	 p r P a t i e n t T i m e = 1   	 p r A c t i v e C l o s e O r d e r C u r r e n t C a n d l e = 1   	 p r B r e a k E v e n P o i n t = 5   	 p r T r a i l i n g S t o p M e t h o d = 5   	 p r P r o f i t T o T r a i l i n g S t o p = 1 0 0   	 p r T r a i l i n g P a r a m e t e r = 2 0   	 p r F a s t M V T y p e = 1   	 p r S l o w M V T y p e = 0   	 p r B a l a n c e R i s k V o l u m e = 0 . 0 5   	 p r M a n u a l T a k e P r o f i t = 0   	 p _ n O p e n O r d e r _ R i s k A n a l y s i s = 2   	 p _ n O p e n O r d e r _ R i s k A n a l y s i s _ L e v e l U p = 9 0   	 p _ n O p e n O r d e r _ R i s k A n a l y s i s _ L e v e l D o w n =  
 5 2 2 7 	 1 5 7 5 . 5 4 	 1 4 3 	 1 . 0 3 	 1 1 . 0 2 	 1 8 4 9 2 . 3 4 	 1 3 . 8 6 % 	 0 . 1 7 1 8 7 5 0 0 	 p r M V O p e n O r d e r O p t i m i z e S e r i e s = 1   	 p r M V s M a x C l o s e D i s t a n c e = 8 0   	 p r A c t i v e B r e a k E v e n D i s t a n c e = - 2   	 p _ n T a k e P r o f i t M e t h o d = - 2   	 p r S t o p L o s s T y p e = 5   	 p r S t o p L o s s P a r a m e t e r = 3 4   	 p _ n H i g h e r T i m e F r a m e _ F a s t M V = 9   	 p _ n H i g h e r T i m e F r a m e _ S l o w M V = 2 1 	 p r O p t i m i s e d P r o f i l e L o a d = 1   	 p r F a s t M V P e r i o d = 2 1   	 p r S l o w M V P e r i o d = 3 4   	 p r M V s M i n O p e n D i s t a n c e = 2 7   	 p r O r d e r A s T r e n d = 1   	 p r T r a i l i n g C o m b i n a t i o n P a r a m e t e r = - 1   	 p r O p t T s t B r T r D i s O p t i m i z a t i o n S e r i e s = - 1   	 p r P a t i e n t T i m e = 1   	 p r A c t i v e C l o s e O r d e r C u r r e n t C a n d l e = 1   	 p r B r e a k E v e n P o i n t = 5   	 p r T r a i l i n g S t o p M e t h o d = 5   	 p r P r o f i t T o T r a i l i n g S t o p = 1 0 0   	 p r T r a i l i n g P a r a m e t e r = 2 0   	 p r F a s t M V T y p e = 1   	 p r S l o w M V T y p e = 0   	 p r B a l a n c e R i s k V o l u m e = 0 . 0 5   	 p r M a n u a l T a k e P r o f i t = 0   	 p _ n O p e n O r d e r _ R i s k A n a l y s i s = 2   	 p _ n O p e n O r d e r _ R i s k A n a l y s i s _ L e v e l U p = 9 0   	 p _ n O p e n O r d e r _ R i s k A n a l y s i s _ L e v e l D o w n =  
  
 * /  
       S l o w M V T y p e   =   M O D E _ S M A ;  
       A c t i v e C l o s e O r d e r C u r r e n t C a n d l e   =   P R E V I O U S _ C A N D L E   ;  
       m _ n L o t M a n a g e m e n t M e t h o d   =   E N U M _ L O T _ M A N A G E M E N T _ S L _ B E L O W _ S M V   ;  
       B r e a k E v e n P o i n t   =   3 7 ;   / /   i n   r o b o f o r e x   s p r e a d   i s   w i d e   2 5   p i p   ,   s o   B r e a k E v e n t   m u s t   h i g h e r  
 / /   C a n   b e   I n t e l l i g e n t   ? ? ?   P e r c e n t   D r a w   D o w n   N o t   D e t e r m i n e d  
       B a l a n c e R i s k V o l u m e   =   0 . 0 1 5 ; / / 0 . 0 1 5   ;   / / S t a n d a r d   M o n e y   M a n a g e m e n t   i s   M a x i m u m   R i s k   2 . 5 %  
  
       F a s t M V P e r i o d   =   3 0 ;  
       S l o w M V P e r i o d   =   5 0 ;  
       F a s t M V T y p e   =   M O D E _ L W M A ;  
       / / B e t w e e n   1 . 3   t o   1 . 7  
       i n t   n M V S t I n d e x   =   F i n d M V S t a t i s t i c s ( ) ;  
  
       / / M V s M i n O p e n D i s t a n c e   =   ( n M V S t I n d e x > - 1 )   ?   ( i n t ) ( M a t h R o u n d ( o p t M V S t a t i s t i c s [ n M V S t I n d e x ] . m _ f M e a n + 1 . 7 * o p t M V S t a t i s t i c s [ n M V S t I n d e x ] . m _ f S t d ) )   :   2 5 0 ;  
  
 M V s M i n O p e n D i s t a n c e   =   ( n M V S t I n d e x > - 1 )   ?   ( i n t ) ( M a t h R o u n d ( o p t M V S t a t i s t i c s [ n M V S t I n d e x ] . m _ f M e a n + 1 . 5 5 * o p t M V S t a t i s t i c s [ n M V S t I n d e x ] . m _ f S t d ) )   :   2 5 0 ;  
  
 / / O t h e r s   C a u s e   T r a d e s C o u n t     d e c r e a s e   b e l o w   c r i t e r i a  
       m _ n O p e n O r d e r _ R i s k A n a l y s i s   =   E N U M _ O P E N O R D E R _ R I S K A N A L Y S I S _ R S I _ B A S E D ;  
       m _ n O p e n O r d e r _ R i s k A n a l y s i s _ R S I U p   =   8 5 ;  
       m _ n O p e n O r d e r _ R i s k A n a l y s i s _ R S I D o w n   =   2 0 ;  
 / / m _ n O p e n O r d e r _ R i s k A n a l y s i s _ D L B U p   =   8 4 ;  
 / / m _ n O p e n O r d e r _ R i s k A n a l y s i s _ D L B D o w n   =   1 6 ;  
  
  
       m _ n I n i t O r d e r S e t R u l e   =   E N U M _ I N I T O R D E R _ S E T _ A L L S P O T ;  
  
 / / B e t w e e n   - 0 . 5   t o   0 . 5  
       M V s M a x C l o s e D i s t a n c e   =   ( n M V S t I n d e x > - 1 )   ?   ( i n t ) ( o p t M V S t a t i s t i c s [ n M V S t I n d e x ] . m _ f M e a n )   :   8 0 ;  
  
       m _ n S t o p L o s s T y p e   =   E N U M _ S T O P L O S S _ B E L O W _ C U S T O M _ M V _ U P D A T E B L E ;   / /   E N U M _ S T O P L O S S _ B E L O W _ C U S T O M _ M V _ C L O S E _ B A S E D ; / /   E N U M _ S T O P L O S S _ B E L O W _ S L O W _ M V ;   / / O p t 2   D o n e   E f f e c t i v e  
       / / T r a d e O f f   B e t w e e n   M o r e   L o s s   ,   L i m i t   L o s s e s   ,   N o t   E f f e c t   O n   P r o f i t   A v e r a g e   O f   L o s s e d   a n d   S t d   ,   I n c r e a s e   W i n   R a t i o  
       / / L o s s C o u n t   L o w   a n d   A v g   L o w   ( T r a d e C o u n t   -   L o s s C o u n t ) / A v g L o s s  
  
       m _ n S t o p L o s s P a r a m e t e r   =   3 4 ;     / / O p t 2   D o n e   E f f e c t i v e  
  
       / / d e f a u l t   a f t e r   6 H o u r s   c l o s e   ,   n o t   u s e d   r e a l l y   b e c a u s e   o f   S i g n a l   M a C D  
       m _ n T i m e L i m i t _ S t o p L o s s   =   2 4 ;  
  
 / / i n   r o b o f o r e x   i n   1   y e a r   d a t a   s o m e   c a n d l e s   i s   v e r y   h i g h   n a v a s a n   ,   i n   o n e   t r a d e   I   b e c o m e   c a l l   m a r g i n   ,   n o t   a c c e p t a b l e ,  
 / /   I n   o n e   e x p e r i e n c e   s o   n e a r   t o   s t o p   l o s s   o r d e r   o p e n   ,   s o   h u g e   l o t   ,   a n d   I   b e c o m e   c a l l   m a r g i n  
       P a t i e n t T i m e   =   O n e C a n d l e I n M i d d l e ;   / / O p t 1   D o n e   L i t t l e   E f f e c t  
 / / i n t e l l i g e n t   c a n   n o t   w o r k   ,   t h i s   i s   a n   s t a n d a r d   t o   s a v e   p r o f i t   ,   1 0 0 %   ,   2 0 0 %   v a   . . . .  
       A c t i v e B r e a k E v e n D i s t a n c e   =   E N U M _ B R E A K E V E N _ F I X E D _ 2 0 ;   / / E N U M _ B R E A K E V E N _ I N T E L L I G E N T ;   / / E N U M _ B R E A K E V E N _ R _ R _ 1 0 0   ;   / / O p t 2   D o n e   E f f e c t i v e  
  
       m _ n T a k e P r o f i t M e t h o d   =   E N U M _ T A K E P R O F I T _ R _ R _ 2 0 0 ; / / E N U M _ T A K E P R O F I T _ M M _ R _ R ;  
       m _ f S t a t _ P r o f i t _ A v g   =   1 0 0 ;  
       m _ f S t a t _ P r o f i t _ S t d   =   8 0 ;  
       m _ n B r e a k E v e n _ I n t e l l i g e n t _ P i p D i s t a n c e _ A c t i v a t i o n   =     4 0 ;  
  
       P r o f i t T o T r a i l i n g S t o p   =   E N U M _ T R A I L I N G _ S T O P _ R S I _ S A T U R A T I O N ; / /   E N U M _ T R A I L I N G _ S T O P _ R S I _ S A T U R A T I O N   ;   / / 8 0   ;  
       T r a i l i n g S t o p M e t h o d   =   E N U M _ T R A I L I N G S T O P _ A T R ;   / / E N U M _ T R A I L I N G S T O P _ A T R 1 5   ;     / /  
 / / C h a n g e   F r o m   1 3   T o   2 1   ,   P o s i t i v e   I   t h o u g h t  
       T r a i l i n g P a r a m e t e r   =   1 4 ;   / /   3 0 ;  
 / / m _ n T r a i l i n g S t o p _ R S I _ O v e r S o l d L e v e l   &   m _ n T r a i l i n g S t o p _ R S I _ O v e r B o u g h t L e v e l   m u s t   b e   r a t i o n a l   a n d   l o g i c a l   n o t   o v e r f i t ,   O v e r S o l d   > =   1 0 0 - O v e r B o u g h t  
       m _ n T r a i l i n g S t o p _ R S I _ O v e r S o l d L e v e l   =   2 0 ; / / 2 4 ;  
       m _ n T r a i l i n g S t o p _ R S I _ O v e r B o u g h t L e v e l   =   8 4 ; / /   7 8 ;  
  
  
       O r d e r A s T r e n d   =   E N U M _ T R E N D _ H I G H E R _ T I M E F R A M E   ;   / / E N U M _ T R E N D _ D E T E R M I N E _ N O N E ; / /   E N U M _ T R E N D _ G O L D E N C R O S S   ;  
       m _ n H i g h e r T i m e F r a m e _ F a s t M V   =   9 ;   / / O P t 3   D o n e   E f f e c t i v e  
       m _ n H i g h e r T i m e F r a m e _ S l o w M V   =   2 1 ;   / / O P t 3   D o n e   E f f e c t i v e  
  
 / / n o t   a n s w e r   R S I   a n d   ,   D I S A B L E   i s   s i m i l a r   t o   R S I _ C A N D L E S T I C K  
       m _ n B i g S t o p _ F i x e d L o t   =   f a l s e ;  
 / /  
 / / m _ n H o u r s R e s t _ W h e n B i g L o s s   m u s t   s e t   w h e n   n o r m a l   c o n d i t i o n   a n d   P r o f i t   a n d   S t o p   L o s s   i s   r a t i o n a l   a n d   l o g i c a l .     N o w   o n l y   w a n t   f i n d   B e s t   O p e n   O r d e r   P o s i t i o n  
       m _ n H o u r s R e s t _ W h e n B i g L o s s   =   3 6 ;   / /   A d v i s e   a l l   M o n e y   M a n a g e m e n t   S y s t e m s   / / O P t 4   D o n e   L o w   E f f e c t  
       m _ f L o s s _ R i s k B a l a n c e _ R a t i o _ R e s t   =   1 . 2 5 ;                                                                       / / O P t 4   D o n e   N o t   E f f e c t  
       m _ n T i m e T r a d e M a n a g e r   =   E N U M _ T I M E _ T R A D E _ F R I D A Y _ A F T E R N O O N _ N O T _ O P E N   ;   / /   E N U M _ T I M E _ T R A D E _ H O L I D A Y _ O F F S E T   ;  
  
       m _ n A c t i v e S t a i r T r a d i n g M a n a g e m e n t   =     E N U M _ S T A I R T R A D I N G _ M A N A G E M E N T _ N O N E ;   / /   E N U M _ S T A I R T R A D I N G _ M A N A G E M E N T _ S T C _ C O M P E N S A T E   ;   / / E N U M _ S T A I R T R A D I N G _ M A N A G E M E N T _ S T C _ C O M P E N S A T E   ;   / / E N U M _ S T A I R T R A D I N G _ M A N A G E M E N T _ S T C _ C O M P E N S A T E ;  
       m _ n I s _ E x i t S i g n a l _ N o n M V M e t h o d   =   E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ D I S A B L E ; / / E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ C A N D L E S T I C K _ A N D _ D I V E R G E N C E ; / / E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ D I S A B L E ;   / / E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ O N L Y _ D I V E R G E N C E ;   / /   E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ O N L Y _ D I V E R G E N C E ;  
       m _ n S i g n a l M A C D P e r i o d   =   1 2   ;  
    
       m _ n M a x S l o p e _ 4 5 _ D i s t a n c e   =   2 0 ;  
       m _ n M a x S l o p e _ S t o p _ D i s t a n c e   =   4 0 ;  
     }  
  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |                                                                                                                                     |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 v o i d   C E A P r o f i l e : : L o a d _ E U R U S D _ 6 0 ( )  
     {  
       S l o w M V P e r i o d   =   2 6 ;  
       F a s t M V P e r i o d   =   1 2 ;  
       F a s t M V T y p e   =   M O D E _ L W M A   ;  
       S l o w M V T y p e   =   M O D E _ S M A ;  
       M V s M i n O p e n D i s t a n c e   =   4 4 ;  
       M V s M a x C l o s e D i s t a n c e   =   1 1   ;  
       A c t i v e C l o s e O r d e r C u r r e n t C a n d l e   =   P R E V I O U S _ C A N D L E   ;  
       O r d e r A s T r e n d   =   E N U M _ T R E N D _ H I G H E R _ T I M E F R A M E   ;  
       A c t i v e B r e a k E v e n D i s t a n c e   =   0   ;  
       P r o f i t T o T r a i l i n g S t o p   =   E N U M _ T R A I L I N G _ S T O P _ F I X E D _ 7 5   ;  
       T r a i l i n g S t o p M e t h o d   =   E N U M _ T R A I L I N G S T O P _ A T R 1 5   ;  
       T r a i l i n g P a r a m e t e r   =   3 0 ;  
       P a t i e n t T i m e   =   O n e C a n d l e I n M i d d l e ;  
       m _ n I s _ E x i t S i g n a l _ N o n M V M e t h o d   =   E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ C A N D L E S T I C K _ A N D _ D I V E R G E N C E ;  
       m _ n S t o p L o s s T y p e   =   E N U M _ S T O P L O S S _ B E L O W _ S L O W _ M V ;  
  
     }  
  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |                                                                                                                                     |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 v o i d   C E A P r o f i l e : : L o a d _ A U D U S D _ 1 5 ( )  
     {  
       S l o w M V T y p e   =   M O D E _ S M A ;  
       A c t i v e C l o s e O r d e r C u r r e n t C a n d l e   =   P R E V I O U S _ C A N D L E   ;  
       m _ n L o t M a n a g e m e n t M e t h o d   =   E N U M _ L O T _ M A N A G E M E N T _ S L _ B E L O W _ S M V   ;  
       B r e a k E v e n P o i n t   =   3 5 ;   / /   i n   r o b o f o r e x   s p r e a d   i s   w i d e   2 5   p i p   ,   s o   B r e a k E v e n t   m u s t   h i g h e r  
       B a l a n c e R i s k V o l u m e   =   0 . 0 3 ; / / 0 . 0 1 5   ;   / / S t a n d a r d   M o n e y   M a n a g e m e n t   i s   M a x i m u m   R i s k   2 . 5 %  
  
       / *  
       S l o w M V P e r i o d   =   5 0 ;  
       F a s t M V P e r i o d   =   2 1 ;  
       F a s t M V T y p e   =   M O D E _ E M A ;  
       M V s M i n O p e n D i s t a n c e   =   1 9 0 ;  
       * /  
  
       m _ n I n i t O r d e r S e t R u l e   =   E N U M _ I N I T O R D E R _ S E T _ A L L S P O T ;  
  
 / / M V s M a x C l o s e D i s t a n c e   =   7 0   ;  
 / / A c t i v e B r e a k E v e n D i s t a n c e   =   E N U M _ B R E A K E V E N _ R _ R _ 1 0 0   ;   / / ;  
       P r o f i t T o T r a i l i n g S t o p   =   E N U M _ T R A I L I N G _ S T O P _ R S I _ S A T U R A T I O N ; / /   E N U M _ T R A I L I N G _ S T O P _ R S I _ S A T U R A T I O N   ;   / / 8 0   ;  
       T r a i l i n g S t o p M e t h o d   =   E N U M _ T R A I L I N G S T O P _ A T R ;   / / E N U M _ T R A I L I N G S T O P _ A T R 1 5   ;     / /  
 / / C h a n g e   F r o m   1 3   T o   2 1   ,   P o s i t i v e   I   t h o u g h t  
       T r a i l i n g P a r a m e t e r   =   3 4 ;   / /   3 0 ;  
       m _ n I s _ E x i t S i g n a l _ N o n M V M e t h o d   =   E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ D I S A B L E ; / / E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ C A N D L E S T I C K _ A N D _ D I V E R G E N C E ; / / E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ D I S A B L E ;   / / E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ O N L Y _ D I V E R G E N C E ;   / /   E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ O N L Y _ D I V E R G E N C E ;  
       m _ n S i g n a l M A C D P e r i o d   =   1 3   ;  
       m _ n S t o p L o s s T y p e   =   E N U M _ S T O P L O S S _ B E L O W _ C U S T O M _ M V ; / /   E N U M _ S T O P L O S S _ B E L O W _ S L O W _ M V ;  
 / / m _ n S t o p L o s s P a r a m e t e r   =   3 4 ;  
       m _ n T i m e L i m i t _ S t o p L o s s   =   0 ;  
       m _ n O p e n O r d e r _ R i s k A n a l y s i s   =   E N U M _ O P E N O R D E R _ R I S K A N A L Y S I S _ D I S A B L E ;  
  
       O r d e r A s T r e n d   =   E N U M _ T R E N D _ H I G H E R _ T I M E F R A M E   ;   / / E N U M _ T R E N D _ D E T E R M I N E _ N O N E ; / /   E N U M _ T R E N D _ G O L D E N C R O S S   ;  
 / / i n   r o b o f o r e x   i n   1   y e a r   d a t a   s o m e   c a n d l e s   i s   v e r y   h i g h   n a v a s a n   ,   i n   o n e   t r a d e   I   b e c o m e   c a l l   m a r g i n   ,   n o t   a c c e p t a b l e ,  
 / /   I n   o n e   e x p e r i e n c e   s o   n e a r   t o   s t o p   l o s s   o r d e r   o p e n   ,   s o   h u g e   l o t   ,   a n d   I   b e c o m e   c a l l   m a r g i n  
       P a t i e n t T i m e   =   O n e C a n d l e I n M i d d l e ;  
 / / n o t   a n s w e r   R S I   a n d   ,   D I S A B L E   i s   s i m i l a r   t o   R S I _ C A N D L E S T I C K  
       m _ n A c t i v e S t a i r T r a d i n g M a n a g e m e n t   =     E N U M _ S T A I R T R A D I N G _ M A N A G E M E N T _ N O N E ;   / /   E N U M _ S T A I R T R A D I N G _ M A N A G E M E N T _ S T C _ C O M P E N S A T E   ;   / / E N U M _ S T A I R T R A D I N G _ M A N A G E M E N T _ S T C _ C O M P E N S A T E   ;   / / E N U M _ S T A I R T R A D I N G _ M A N A G E M E N T _ S T C _ C O M P E N S A T E ;  
       m _ n B i g S t o p _ F i x e d L o t   =   f a l s e ;  
       m _ n H o u r s R e s t _ W h e n B i g L o s s   =   3 6 ;   / /   A d v i s e   a l l   M o n e y   M a n a g e m e n t   S y s t e m s  
       m _ f L o s s _ R i s k B a l a n c e _ R a t i o _ R e s t   =   1 . 0 ;  
       m _ n T i m e T r a d e M a n a g e r   =   E N U M _ T I M E _ T R A D E _ H O L I D A Y _ O F F S E T _ F R I D A Y _ A F T E R N O O N _ N O T _ O P E N   ;   / /   E N U M _ T I M E _ T R A D E _ H O L I D A Y _ O F F S E T   ;  
       m _ f S t a t _ P r o f i t _ A v g   =   1 2 9 ;  
       m _ f S t a t _ P r o f i t _ S t d   =   2 2 7 . 3 ;  
       m _ n B r e a k E v e n _ I n t e l l i g e n t _ P i p D i s t a n c e _ A c t i v a t i o n   =   3 ;  
  
       m _ n H i g h e r T i m e F r a m e _ F a s t M V   =   p _ n H i g h e r T i m e F r a m e _ F a s t M V ; / / 2 1 ;               / / O p t 9  
       m _ n H i g h e r T i m e F r a m e _ S l o w M V   =   p _ n H i g h e r T i m e F r a m e _ S l o w M V ; / / 2 6 ;             / / O p t 9  
       m _ n T r a i l i n g S t o p _ R S I _ O v e r S o l d L e v e l   =   p _ n T r a i l i n g S t o p _ R S I _ O v e r S o l d L e v e l ;         / / O p t 1 0  
       m _ n T r a i l i n g S t o p _ R S I _ O v e r B o u g h t L e v e l   =   p _ n T r a i l i n g S t o p _ R S I _ O v e r B o u g h t L e v e l ;       / / O p t 1 0  
  
     }  
  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |                                                                                                                                     |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 v o i d   C E A P r o f i l e : : L o a d _ U S D J P Y _ 1 5 ( )  
     {  
       / *  
       E N U M _ O P E N O R D E R _ R I S K A N A L Y S I S _ D I S A B L E  
       / /     2 0 2 1 . 1 0 . 0 3   2 0 : 1 3 : 4 0 . 0 3 2       2 0 1 9 . 0 3 . 2 6   2 2 : 3 0 : 0 0     E A _ M A C r o s s _ V 1 5   U S D J P Y , M 1 5 :   L o a d P r o f i l e   L o a d P r o f i l e   9 ; 3 0 ; M O D E _ L W M A ; M O D E _ S M A ; 2 2 0 ; 4 0 ; P R E V I O U S _ C A N D L E ; E N U M _ T R E N D _ H I G H E R _ T I M E F R A M E ; T w o C a n d l e I n M i d d l e ; E N U M _ B R E A K E V E N _ R _ R _ 1 0 0 ; - 1 ; E N U M _ T R A I L I N G S T O P _ A T R ; 2 0 ; E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ D I S A B L E ; E N  
  
         S l o w M V T y p e   =   M O D E _ S M A ;  
         A c t i v e C l o s e O r d e r C u r r e n t C a n d l e   =   P R E V I O U S _ C A N D L E   ;  
         m _ n L o t M a n a g e m e n t M e t h o d   =   E N U M _ L O T _ M A N A G E M E N T _ S L _ B E L O W _ S M V   ;  
         B r e a k E v e n P o i n t   =   3 5 ;   / /   i n   r o b o f o r e x   s p r e a d   i s   w i d e   2 5   p i p   ,   s o   B r e a k E v e n t   m u s t   h i g h e r  
         B a l a n c e R i s k V o l u m e   =   0 . 0 3 ; / / 0 . 0 1 5   ;   / / S t a n d a r d   M o n e y   M a n a g e m e n t   i s   M a x i m u m   R i s k   2 . 5 %  
  
  
         S l o w M V P e r i o d   =   E N U M _ N O R M A L _ M V 3 4 ;  
         F a s t M V P e r i o d   =   E N U M _ N O R M A L _ M V 0 9 ;  
         M V s M i n O p e n D i s t a n c e   =   1 9 0 ;   / / O p t   D o n e  
  
         / / F a s t M V T y p e   =   M O D E _ L W M A ;  
         F a s t M V T y p e   =   M O D E _ E M A ;  
  
         m _ n I n i t O r d e r S e t R u l e   =   E N U M _ I N I T O R D E R _ S E T _ A L L S P O T ;  
  
         M V s M a x C l o s e D i s t a n c e   =   4 0 ; / / 1 5 0   ;   / / O p t   D o n e  
         A c t i v e B r e a k E v e n D i s t a n c e   =   E N U M _ B R E A K E V E N _ R _ R _ 1 0 0 ; / / E N U M _ B R E A K E V E N _ I N T E L L I G E N T _ S T A T I S T I C S ; / / E N U M _ B R E A K E V E N _ I N T E L L I G E N T ;   / / E N U M _ B R E A K E V E N _ R _ R _ 1 0 0   ;   / / O p t   D o n e  
         P r o f i t T o T r a i l i n g S t o p   =   E N U M _ T R A I L I N G _ S T O P _ R S I _ S A T U R A T I O N ; / /   E N U M _ T R A I L I N G _ S T O P _ R S I _ S A T U R A T I O N   ;   / / 8 0   ;  
         T r a i l i n g S t o p M e t h o d   =   E N U M _ T R A I L I N G S T O P _ A T R ;   / / E N U M _ T R A I L I N G S T O P _ A T R 1 5   ;     / / O p t   D o n e  
       / / C h a n g e   F r o m   1 3   T o   2 1   ,   P o s i t i v e   I   t h o u g h t  
         T r a i l i n g P a r a m e t e r   =   2 0 ;   / /   3 0 ;       / / O p t   D o n e  
         m _ n I s _ E x i t S i g n a l _ N o n M V M e t h o d   =   E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ D I S A B L E ; / / E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ C A N D L E S T I C K _ A N D _ D I V E R G E N C E ; / / E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ D I S A B L E ;   / / E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ O N L Y _ D I V E R G E N C E ;   / /   E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ O N L Y _ D I V E R G E N C E ;  
         m _ n S i g n a l M A C D P e r i o d   =   1 2   ;  
         m _ n S t o p L o s s T y p e   =   E N U M _ S T O P L O S S _ B E L O W _ C U S T O M _ M V ; / / E N U M _ S T O P L O S S _ B E L O W _ C U S T O M _ M V _ C L O S E _ B A S E D ; / /   E N U M _ S T O P L O S S _ B E L O W _ S L O W _ M V ;   / / O p t   D o n e  
         m _ n S t o p L o s s P a r a m e t e r   =   2 6 ;   / / O p t   D o n e  
         m _ n T i m e L i m i t _ S t o p L o s s   =   1 5 ;  
         m _ n O p e n O r d e r _ R i s k A n a l y s i s   =   E N U M _ O P E N O R D E R _ R I S K A N A L Y S I S _ D L B _ B A S E D ;  
  
         O r d e r A s T r e n d   =   E N U M _ T R E N D _ H I G H E R _ T I M E F R A M E   ;   / / E N U M _ T R E N D _ D E T E R M I N E _ N O N E ; / /   E N U M _ T R E N D _ G O L D E N C R O S S   ;  
       / / i n   r o b o f o r e x   i n   1   y e a r   d a t a   s o m e   c a n d l e s   i s   v e r y   h i g h   n a v a s a n   ,   i n   o n e   t r a d e   I   b e c o m e   c a l l   m a r g i n   ,   n o t   a c c e p t a b l e ,  
       / /   I n   o n e   e x p e r i e n c e   s o   n e a r   t o   s t o p   l o s s   o r d e r   o p e n   ,   s o   h u g e   l o t   ,   a n d   I   b e c o m e   c a l l   m a r g i n  
         P a t i e n t T i m e   =   H u r y U p ;  
       / / n o t   a n s w e r   R S I   a n d   ,   D I S A B L E   i s   s i m i l a r   t o   R S I _ C A N D L E S T I C K  
         m _ n A c t i v e S t a i r T r a d i n g M a n a g e m e n t   =     E N U M _ S T A I R T R A D I N G _ M A N A G E M E N T _ N O N E ;   / /   E N U M _ S T A I R T R A D I N G _ M A N A G E M E N T _ S T C _ C O M P E N S A T E   ;   / / E N U M _ S T A I R T R A D I N G _ M A N A G E M E N T _ S T C _ C O M P E N S A T E   ;   / / E N U M _ S T A I R T R A D I N G _ M A N A G E M E N T _ S T C _ C O M P E N S A T E ;  
         m _ n B i g S t o p _ F i x e d L o t   =   f a l s e ;  
         m _ n H o u r s R e s t _ W h e n B i g L o s s   =   4 2 ;   / /   A d v i s e   a l l   M o n e y   M a n a g e m e n t   S y s t e m s  
         m _ f L o s s _ R i s k B a l a n c e _ R a t i o _ R e s t   =   1 . 2 5 ;  
         m _ n T i m e T r a d e M a n a g e r   =   E N U M _ T I M E _ T R A D E _ F R I D A Y _ A F T E R N O O N _ N O T _ O P E N   ;   / /   E N U M _ T I M E _ T R A D E _ H O L I D A Y _ O F F S E T   ;  
         m _ f S t a t _ P r o f i t _ A v g   =   1 2 2 . 8 ;  
         m _ f S t a t _ P r o f i t _ S t d   =   1 3 8 . 3 ;  
  
         m _ n H i g h e r T i m e F r a m e _ F a s t M V   =   2 1 ; / / 1 3 ; / / 2 1 ;               / / O p t 9  
         m _ n H i g h e r T i m e F r a m e _ S l o w M V   =   2 6 ; / / 2 1 ; / / 2 6 ;             / / O p t 9  
         m _ n T r a i l i n g S t o p _ R S I _ O v e r S o l d L e v e l   =   3 2 ;         / / O p t   D o n e  
         m _ n T r a i l i n g S t o p _ R S I _ O v e r B o u g h t L e v e l   =   7 6 ;       / / O p t   D o n e  
       * /  
       S l o w M V T y p e   =   M O D E _ S M A ;  
       A c t i v e C l o s e O r d e r C u r r e n t C a n d l e   =   P R E V I O U S _ C A N D L E   ;  
       m _ n L o t M a n a g e m e n t M e t h o d   =   E N U M _ L O T _ M A N A G E M E N T _ S L _ B E L O W _ S M V   ;  
       B r e a k E v e n P o i n t   =   3 5 ;   / /   i n   r o b o f o r e x   s p r e a d   i s   w i d e   2 5   p i p   ,   s o   B r e a k E v e n t   m u s t   h i g h e r  
       B a l a n c e R i s k V o l u m e   =   0 . 0 3 ; / / 0 . 0 1 5   ;   / / S t a n d a r d   M o n e y   M a n a g e m e n t   i s   M a x i m u m   R i s k   2 . 5 %  
  
  
       S l o w M V P e r i o d   =   E N U M _ N O R M A L _ M V 3 4 ;  
       F a s t M V P e r i o d   =   E N U M _ N O R M A L _ M V 0 9 ;  
 / / M V s M i n O p e n D i s t a n c e   =   1 9 0 ;   / / O p t   D o n e  
  
  
 / / F a s t M V T y p e   =   M O D E _ L W M A ;  
 / / F a s t M V T y p e   =   M O D E _ E M A ;  
  
       m _ n I n i t O r d e r S e t R u l e   =   E N U M _ I N I T O R D E R _ S E T _ A L L S P O T ;  
  
 / / M V s M a x C l o s e D i s t a n c e   =   4 0 ; / / 1 5 0   ;   / / O p t   D o n e  
       i n t   n M V S t I n d e x   =   F i n d M V S t a t i s t i c s ( ) ;  
       M V s M a x C l o s e D i s t a n c e   =   n M V S t I n d e x > - 1   ?   ( i n t ) M a t h R o u n d ( o p t M V S t a t i s t i c s [ n M V S t I n d e x ] . m _ f M e a n )   :   4 0 ;  
  
       A c t i v e B r e a k E v e n D i s t a n c e   =   E N U M _ B R E A K E V E N _ D I S A B L E D ; / / E N U M _ B R E A K E V E N _ I N T E L L I G E N T _ S T A T I S T I C S ; / / E N U M _ B R E A K E V E N _ I N T E L L I G E N T ;   / / E N U M _ B R E A K E V E N _ R _ R _ 1 0 0   ;   / / O p t   D o n e  
       P r o f i t T o T r a i l i n g S t o p   =   E N U M _ T R A I L I N G _ S T O P _ R S I _ S A T U R A T I O N ; / /   E N U M _ T R A I L I N G _ S T O P _ R S I _ S A T U R A T I O N   ;   / / 8 0   ;  
       T r a i l i n g S t o p M e t h o d   =   E N U M _ T R A I L I N G S T O P _ A T R ;   / / E N U M _ T R A I L I N G S T O P _ A T R 1 5   ;     / / O p t   D o n e  
 / / C h a n g e   F r o m   1 3   T o   2 1   ,   P o s i t i v e   I   t h o u g h t  
       T r a i l i n g P a r a m e t e r   =   2 0 ;   / /   3 0 ;       / / O p t   D o n e  
       m _ n I s _ E x i t S i g n a l _ N o n M V M e t h o d   =   E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ S I G N A L ; / / E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ C A N D L E S T I C K _ A N D _ D I V E R G E N C E ; / / E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ D I S A B L E ;   / / E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ O N L Y _ D I V E R G E N C E ;   / /   E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ O N L Y _ D I V E R G E N C E ;  
       m _ n S i g n a l M A C D P e r i o d   =   1 2   ;  
       m _ n S t o p L o s s T y p e   =   E N U M _ S T O P L O S S _ B E L O W _ C U S T O M _ M V ; / / E N U M _ S T O P L O S S _ B E L O W _ C U S T O M _ M V _ C L O S E _ B A S E D ; / /   E N U M _ S T O P L O S S _ B E L O W _ S L O W _ M V ;   / / O p t   D o n e  
       m _ n S t o p L o s s P a r a m e t e r   =   2 1 ;   / / O p t   D o n e  
       m _ n T i m e L i m i t _ S t o p L o s s   =   0 ;  
       m _ n O p e n O r d e r _ R i s k A n a l y s i s   =   E N U M _ O P E N O R D E R _ R I S K A N A L Y S I S _ D L B _ B A S E D ;  
       m _ n O p e n O r d e r _ R i s k A n a l y s i s _ R S I U p   =   8 7 ;  
       m _ n O p e n O r d e r _ R i s k A n a l y s i s _ R S I D o w n   =   1 8 ;  
       m _ n O p e n O r d e r _ R i s k A n a l y s i s _ D L B U p   =   9 0 ;  
       m _ n O p e n O r d e r _ R i s k A n a l y s i s _ D L B D o w n   =   1 0 ;  
  
       O r d e r A s T r e n d   =   E N U M _ T R E N D _ H I G H E R _ T I M E F R A M E   ;   / / E N U M _ T R E N D _ D E T E R M I N E _ N O N E ; / /   E N U M _ T R E N D _ G O L D E N C R O S S   ;  
 / / i n   r o b o f o r e x   i n   1   y e a r   d a t a   s o m e   c a n d l e s   i s   v e r y   h i g h   n a v a s a n   ,   i n   o n e   t r a d e   I   b e c o m e   c a l l   m a r g i n   ,   n o t   a c c e p t a b l e ,  
 / /   I n   o n e   e x p e r i e n c e   s o   n e a r   t o   s t o p   l o s s   o r d e r   o p e n   ,   s o   h u g e   l o t   ,   a n d   I   b e c o m e   c a l l   m a r g i n  
       P a t i e n t T i m e   =   H u r y U p ;  
 / / n o t   a n s w e r   R S I   a n d   ,   D I S A B L E   i s   s i m i l a r   t o   R S I _ C A N D L E S T I C K  
       m _ n A c t i v e S t a i r T r a d i n g M a n a g e m e n t   =     E N U M _ S T A I R T R A D I N G _ M A N A G E M E N T _ N O N E ;   / /   E N U M _ S T A I R T R A D I N G _ M A N A G E M E N T _ S T C _ C O M P E N S A T E   ;   / / E N U M _ S T A I R T R A D I N G _ M A N A G E M E N T _ S T C _ C O M P E N S A T E   ;   / / E N U M _ S T A I R T R A D I N G _ M A N A G E M E N T _ S T C _ C O M P E N S A T E ;  
       m _ n B i g S t o p _ F i x e d L o t   =   f a l s e ;  
       m _ n H o u r s R e s t _ W h e n B i g L o s s   =   0 ; / / 4 2 ;   / /   A d v i s e   a l l   M o n e y   M a n a g e m e n t   S y s t e m s  
       m _ f L o s s _ R i s k B a l a n c e _ R a t i o _ R e s t   =   1 . 2 5 ;  
       m _ n T i m e T r a d e M a n a g e r   =   E N U M _ T I M E _ T R A D E _ F R I D A Y _ A F T E R N O O N _ N O T _ O P E N   ;   / /   E N U M _ T I M E _ T R A D E _ H O L I D A Y _ O F F S E T   ;  
       m _ f S t a t _ P r o f i t _ A v g   =   1 2 2 . 8 ;  
       m _ f S t a t _ P r o f i t _ S t d   =   1 3 8 . 3 ;  
  
       m _ n H i g h e r T i m e F r a m e _ F a s t M V   =   p _ n H i g h e r T i m e F r a m e _ F a s t M V ; / / 1 3 ; / / 2 1 ;               / / O p t 9  
       m _ n H i g h e r T i m e F r a m e _ S l o w M V   =   p _ n H i g h e r T i m e F r a m e _ S l o w M V ; / / 2 1 ; / / 2 6 ;             / / O p t 9  
       m _ n T r a i l i n g S t o p _ R S I _ O v e r S o l d L e v e l   =   p _ n T r a i l i n g S t o p _ R S I _ O v e r S o l d L e v e l ;         / / O p t   D o n e  
       m _ n T r a i l i n g S t o p _ R S I _ O v e r B o u g h t L e v e l   =   p _ n T r a i l i n g S t o p _ R S I _ O v e r B o u g h t L e v e l ;       / / O p t   D o n e  
     }  
  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |   G B P U S D 1 5                                                                                                                                   |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 v o i d   C E A P r o f i l e : : L o a d _ G B P U S D _ 1 5 ( )  
     {  
       S l o w M V T y p e   =   M O D E _ S M A ;  
       A c t i v e C l o s e O r d e r C u r r e n t C a n d l e   =   P R E V I O U S _ C A N D L E   ;  
       m _ n L o t M a n a g e m e n t M e t h o d   =   E N U M _ L O T _ M A N A G E M E N T _ S L _ B E L O W _ S M V   ;  
       B r e a k E v e n P o i n t   =   3 5 ;   / /   i n   r o b o f o r e x   s p r e a d   i s   w i d e   2 5   p i p   ,   s o   B r e a k E v e n t   m u s t   h i g h e r  
       B a l a n c e R i s k V o l u m e   =   0 . 0 3 ; / / 0 . 0 1 5   ;   / / S t a n d a r d   M o n e y   M a n a g e m e n t   i s   M a x i m u m   R i s k   2 . 5 %  
  
       M V s M i n O p e n D i s t a n c e   =   3 1 0 ;  
       S l o w M V P e r i o d   =   5 0 ;  
       F a s t M V P e r i o d   =   3 0 ;  
       F a s t M V T y p e   =   M O D E _ L W M A ;  
 / / O t h e r s   C a u s e   T r a d e s C o u n t     d e c r e a s e   b e l o w   c r i t e r i a  
       m _ n O p e n O r d e r _ R i s k A n a l y s i s   =   E N U M _ O P E N O R D E R _ R I S K A N A L Y S I S _ D I S A B L E ;  
       m _ n O p e n O r d e r _ R i s k A n a l y s i s _ R S I U p   =   9 0 ;  
       m _ n O p e n O r d e r _ R i s k A n a l y s i s _ R S I D o w n   =   1 0 ;  
       m _ n O p e n O r d e r _ R i s k A n a l y s i s _ D L B U p   =   9 2 ;  
       m _ n O p e n O r d e r _ R i s k A n a l y s i s _ D L B D o w n   =   6 ;  
  
  
       m _ n I n i t O r d e r S e t R u l e   =   E N U M _ I N I T O R D E R _ S E T _ A L L S P O T ;  
  
       M V s M a x C l o s e D i s t a n c e   =   5 5   ;  
       A c t i v e B r e a k E v e n D i s t a n c e   =   E N U M _ B R E A K E V E N _ I N T E L L I G E N T ; / / E N U M _ B R E A K E V E N _ F I X E D _ N 4 ; / / E N U M _ B R E A K E V E N _ I N T E L L I G E N T ;   / / E N U M _ B R E A K E V E N _ R _ R _ 1 0 0   ;   / / O p t 2   D o n e   E f f e c t i v e  
       m _ n T a k e P r o f i t M e t h o d   =   E N U M _ T A K E P R O F I T _ D I S A B L E D ;  
       m _ f S t a t _ P r o f i t _ A v g   =   9 1 ;  
       m _ f S t a t _ P r o f i t _ S t d   =   8 9 . 7 ;  
       m _ n B r e a k E v e n _ I n t e l l i g e n t _ P i p D i s t a n c e _ A c t i v a t i o n   =     3 0 ;  
  
       P r o f i t T o T r a i l i n g S t o p   =   E N U M _ T R A I L I N G _ S T O P _ R S I _ S A T U R A T I O N ; / /   E N U M _ T R A I L I N G _ S T O P _ R S I _ S A T U R A T I O N   ;   / / 8 0   ;  
       T r a i l i n g S t o p M e t h o d   =   E N U M _ T R A I L I N G S T O P _ A T R ;   / / E N U M _ T R A I L I N G S T O P _ A T R 1 5   ;     / /  
 / / C h a n g e   F r o m   1 3   T o   2 1   ,   P o s i t i v e   I   t h o u g h t  
       T r a i l i n g P a r a m e t e r   =   1 3 ;   / /   3 0 ;  
       m _ n T r a i l i n g S t o p _ R S I _ O v e r S o l d L e v e l   =   2 2 ;  
       m _ n T r a i l i n g S t o p _ R S I _ O v e r B o u g h t L e v e l   =   7 0 ;  
  
       m _ n S t o p L o s s T y p e   =   E N U M _ S T O P L O S S _ B E L O W _ C U S T O M _ M V _ C L O S E _ B A S E D ; / /   E N U M _ S T O P L O S S _ B E L O W _ S L O W _ M V ;   / / O p t 2   D o n e   E f f e c t i v e  
       m _ n S t o p L o s s P a r a m e t e r   =   3 0 ;     / / O p t 2   D o n e   E f f e c t i v e  
       m _ n T i m e L i m i t _ S t o p L o s s   =   1 6 ;  
  
       O r d e r A s T r e n d   =   E N U M _ T R E N D _ H I G H E R _ T I M E F R A M E   ;   / / E N U M _ T R E N D _ D E T E R M I N E _ N O N E ; / /   E N U M _ T R E N D _ G O L D E N C R O S S   ;  
       m _ n H i g h e r T i m e F r a m e _ F a s t M V   =   9 ;   / / O P t 3   D o n e   E f f e c t i v e  
       m _ n H i g h e r T i m e F r a m e _ S l o w M V   =   2 6 ;   / / O P t 3   D o n e   E f f e c t i v e  
  
 / / i n   r o b o f o r e x   i n   1   y e a r   d a t a   s o m e   c a n d l e s   i s   v e r y   h i g h   n a v a s a n   ,   i n   o n e   t r a d e   I   b e c o m e   c a l l   m a r g i n   ,   n o t   a c c e p t a b l e ,  
 / /   I n   o n e   e x p e r i e n c e   s o   n e a r   t o   s t o p   l o s s   o r d e r   o p e n   ,   s o   h u g e   l o t   ,   a n d   I   b e c o m e   c a l l   m a r g i n  
       P a t i e n t T i m e   =   O n e C a n d l e I n M i d d l e ;   / / O p t 1   D o n e   L i t t l e   E f f e c t  
 / / n o t   a n s w e r   R S I   a n d   ,   D I S A B L E   i s   s i m i l a r   t o   R S I _ C A N D L E S T I C K  
       m _ n B i g S t o p _ F i x e d L o t   =   f a l s e ;  
       m _ n H o u r s R e s t _ W h e n B i g L o s s   =   3 6 ;   / /   A d v i s e   a l l   M o n e y   M a n a g e m e n t   S y s t e m s   / / O P t 4   D o n e   L o w   E f f e c t  
       m _ f L o s s _ R i s k B a l a n c e _ R a t i o _ R e s t   =   1 . 7 5 ;                                                                       / / O P t 4   D o n e   N o t   E f f e c t  
       m _ n T i m e T r a d e M a n a g e r   =   E N U M _ T I M E _ T R A D E _ H O L I D A Y _ O F F S E T _ F R I D A Y _ A F T E R N O O N _ N O T _ O P E N   ;   / /   E N U M _ T I M E _ T R A D E _ H O L I D A Y _ O F F S E T   ;  
  
       m _ n A c t i v e S t a i r T r a d i n g M a n a g e m e n t   =     E N U M _ S T A I R T R A D I N G _ M A N A G E M E N T _ N O N E ;   / /   E N U M _ S T A I R T R A D I N G _ M A N A G E M E N T _ S T C _ C O M P E N S A T E   ;   / / E N U M _ S T A I R T R A D I N G _ M A N A G E M E N T _ S T C _ C O M P E N S A T E   ;   / / E N U M _ S T A I R T R A D I N G _ M A N A G E M E N T _ S T C _ C O M P E N S A T E ;  
       m _ n I s _ E x i t S i g n a l _ N o n M V M e t h o d   =   E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ D I S A B L E ; / / E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ C A N D L E S T I C K _ A N D _ D I V E R G E N C E ; / / E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ D I S A B L E ;   / / E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ O N L Y _ D I V E R G E N C E ;   / /   E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ O N L Y _ D I V E R G E N C E ;  
       m _ n S i g n a l M A C D P e r i o d   =   1 2   ;  
     }  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |                                                                                                                                     |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 v o i d                             C E A P r o f i l e : : L o a d _ U S D C A D _ 1 5 ( )  
     {  
     }  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |                                                                                                                                     |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 v o i d   C E A P r o f i l e : : L o a d _ G B P U S D _ 6 0 ( )  
     {  
       S l o w M V P e r i o d   =   2 6 ;  
       F a s t M V P e r i o d   =   1 2 ;  
       F a s t M V T y p e   =   M O D E _ L W M A   ;  
       S l o w M V T y p e   =   M O D E _ S M A ;  
       M V s M i n O p e n D i s t a n c e   =   4 4 ;  
       M V s M a x C l o s e D i s t a n c e   =   1 1   ;  
       A c t i v e C l o s e O r d e r C u r r e n t C a n d l e   =   P R E V I O U S _ C A N D L E   ;  
       O r d e r A s T r e n d   =   E N U M _ T R E N D _ H I G H E R _ T I M E F R A M E   ;  
       A c t i v e B r e a k E v e n D i s t a n c e   =   E N U M _ B R E A K E V E N _ D I S A B L E D   ;  
       P r o f i t T o T r a i l i n g S t o p   =   E N U M _ T R A I L I N G _ S T O P _ F I X E D _ 7 5   ;  
       T r a i l i n g S t o p M e t h o d   =   E N U M _ T R A I L I N G S T O P _ A T R 1 5   ;  
       T r a i l i n g P a r a m e t e r   =   3 0 ;  
       P a t i e n t T i m e   =   O n e C a n d l e I n M i d d l e ;  
       m _ n I s _ E x i t S i g n a l _ N o n M V M e t h o d   =   E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ C A N D L E S T I C K _ A N D _ D I V E R G E N C E ;  
       m _ n S t o p L o s s T y p e   =   E N U M _ S T O P L O S S _ B E L O W _ S L O W _ M V ;  
  
     }  
 v o i d   C E A P r o f i l e : : L o a d _ X A G U S D _ 1 5 ( )  
     {  
       S l o w M V T y p e   =   M O D E _ S M A ;  
       A c t i v e C l o s e O r d e r C u r r e n t C a n d l e   =   P R E V I O U S _ C A N D L E   ;  
       m _ n L o t M a n a g e m e n t M e t h o d   =   E N U M _ L O T _ M A N A G E M E N T _ S L _ B E L O W _ S M V   ;  
       B r e a k E v e n P o i n t   =   3 5 ;   / /   i n   r o b o f o r e x   s p r e a d   i s   w i d e   2 5   p i p   ,   s o   B r e a k E v e n t   m u s t   h i g h e r  
       B a l a n c e R i s k V o l u m e   =   0 . 0 3 ; / / 0 . 0 1 5   ;   / / S t a n d a r d   M o n e y   M a n a g e m e n t   i s   M a x i m u m   R i s k   2 . 5 %  
  
       M V s M i n O p e n D i s t a n c e   =   3 1 0 ;  
       S l o w M V P e r i o d   =   5 0 ;  
       F a s t M V P e r i o d   =   3 0 ;  
       F a s t M V T y p e   =   M O D E _ L W M A ;  
 / / O t h e r s   C a u s e   T r a d e s C o u n t     d e c r e a s e   b e l o w   c r i t e r i a  
       m _ n O p e n O r d e r _ R i s k A n a l y s i s   =   E N U M _ O P E N O R D E R _ R I S K A N A L Y S I S _ D I S A B L E ;  
       m _ n O p e n O r d e r _ R i s k A n a l y s i s _ R S I U p   =   9 0 ;  
       m _ n O p e n O r d e r _ R i s k A n a l y s i s _ R S I D o w n   =   1 0 ;  
       m _ n O p e n O r d e r _ R i s k A n a l y s i s _ D L B U p   =   9 2 ;  
       m _ n O p e n O r d e r _ R i s k A n a l y s i s _ D L B D o w n   =   6 ;  
  
  
       m _ n I n i t O r d e r S e t R u l e   =   E N U M _ I N I T O R D E R _ S E T _ A L L S P O T ;  
  
       M V s M a x C l o s e D i s t a n c e   =   5 5   ;  
       A c t i v e B r e a k E v e n D i s t a n c e   =   E N U M _ B R E A K E V E N _ I N T E L L I G E N T ; / / E N U M _ B R E A K E V E N _ F I X E D _ N 4 ; / / E N U M _ B R E A K E V E N _ I N T E L L I G E N T ;   / / E N U M _ B R E A K E V E N _ R _ R _ 1 0 0   ;   / / O p t 2   D o n e   E f f e c t i v e  
       m _ n T a k e P r o f i t M e t h o d   =   E N U M _ T A K E P R O F I T _ D I S A B L E D ;  
       m _ f S t a t _ P r o f i t _ A v g   =   9 1 ;  
       m _ f S t a t _ P r o f i t _ S t d   =   8 9 . 7 ;  
       m _ n B r e a k E v e n _ I n t e l l i g e n t _ P i p D i s t a n c e _ A c t i v a t i o n   =     3 0 ;  
  
       P r o f i t T o T r a i l i n g S t o p   =   E N U M _ T R A I L I N G _ S T O P _ R S I _ S A T U R A T I O N ; / /   E N U M _ T R A I L I N G _ S T O P _ R S I _ S A T U R A T I O N   ;   / / 8 0   ;  
       T r a i l i n g S t o p M e t h o d   =   E N U M _ T R A I L I N G S T O P _ A T R ;   / / E N U M _ T R A I L I N G S T O P _ A T R 1 5   ;     / /  
 / / C h a n g e   F r o m   1 3   T o   2 1   ,   P o s i t i v e   I   t h o u g h t  
       T r a i l i n g P a r a m e t e r   =   1 3 ;   / /   3 0 ;  
       m _ n T r a i l i n g S t o p _ R S I _ O v e r S o l d L e v e l   =   2 2 ;  
       m _ n T r a i l i n g S t o p _ R S I _ O v e r B o u g h t L e v e l   =   7 0 ;  
  
       m _ n S t o p L o s s T y p e   =   E N U M _ S T O P L O S S _ B E L O W _ C U S T O M _ M V _ C L O S E _ B A S E D ; / /   E N U M _ S T O P L O S S _ B E L O W _ S L O W _ M V ;   / / O p t 2   D o n e   E f f e c t i v e  
       m _ n S t o p L o s s P a r a m e t e r   =   3 0 ;     / / O p t 2   D o n e   E f f e c t i v e  
       m _ n T i m e L i m i t _ S t o p L o s s   =   1 6 ;  
  
       O r d e r A s T r e n d   =   E N U M _ T R E N D _ H I G H E R _ T I M E F R A M E   ;   / / E N U M _ T R E N D _ D E T E R M I N E _ N O N E ; / /   E N U M _ T R E N D _ G O L D E N C R O S S   ;  
       m _ n H i g h e r T i m e F r a m e _ F a s t M V   =   9 ;   / / O P t 3   D o n e   E f f e c t i v e  
       m _ n H i g h e r T i m e F r a m e _ S l o w M V   =   2 6 ;   / / O P t 3   D o n e   E f f e c t i v e  
  
 / / i n   r o b o f o r e x   i n   1   y e a r   d a t a   s o m e   c a n d l e s   i s   v e r y   h i g h   n a v a s a n   ,   i n   o n e   t r a d e   I   b e c o m e   c a l l   m a r g i n   ,   n o t   a c c e p t a b l e ,  
 / /   I n   o n e   e x p e r i e n c e   s o   n e a r   t o   s t o p   l o s s   o r d e r   o p e n   ,   s o   h u g e   l o t   ,   a n d   I   b e c o m e   c a l l   m a r g i n  
       P a t i e n t T i m e   =   O n e C a n d l e I n M i d d l e ;   / / O p t 1   D o n e   L i t t l e   E f f e c t  
 / / n o t   a n s w e r   R S I   a n d   ,   D I S A B L E   i s   s i m i l a r   t o   R S I _ C A N D L E S T I C K  
       m _ n B i g S t o p _ F i x e d L o t   =   f a l s e ;  
       m _ n H o u r s R e s t _ W h e n B i g L o s s   =   3 6 ;   / /   A d v i s e   a l l   M o n e y   M a n a g e m e n t   S y s t e m s   / / O P t 4   D o n e   L o w   E f f e c t  
       m _ f L o s s _ R i s k B a l a n c e _ R a t i o _ R e s t   =   1 . 7 5 ;                                                                       / / O P t 4   D o n e   N o t   E f f e c t  
       m _ n T i m e T r a d e M a n a g e r   =   E N U M _ T I M E _ T R A D E _ H O L I D A Y _ O F F S E T _ F R I D A Y _ A F T E R N O O N _ N O T _ O P E N   ;   / /   E N U M _ T I M E _ T R A D E _ H O L I D A Y _ O F F S E T   ;  
  
       m _ n A c t i v e S t a i r T r a d i n g M a n a g e m e n t   =     E N U M _ S T A I R T R A D I N G _ M A N A G E M E N T _ N O N E ;   / /   E N U M _ S T A I R T R A D I N G _ M A N A G E M E N T _ S T C _ C O M P E N S A T E   ;   / / E N U M _ S T A I R T R A D I N G _ M A N A G E M E N T _ S T C _ C O M P E N S A T E   ;   / / E N U M _ S T A I R T R A D I N G _ M A N A G E M E N T _ S T C _ C O M P E N S A T E ;  
       m _ n I s _ E x i t S i g n a l _ N o n M V M e t h o d   =   E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ D I S A B L E ; / / E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ C A N D L E S T I C K _ A N D _ D I V E R G E N C E ; / / E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ D I S A B L E ;   / / E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ O N L Y _ D I V E R G E N C E ;   / /   E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ O N L Y _ D I V E R G E N C E ;  
       m _ n S i g n a l M A C D P e r i o d   =   1 2   ;  
     }  
  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |                                                                                                                                     |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 v o i d   C E A P r o f i l e : : L o a d _ O p t i m i z a t i o n _ O p e n O r d e r _ L e v e l 1 ( )  
     {  
  
       S l o w M V T y p e   =   M O D E _ S M A ;  
       A c t i v e C l o s e O r d e r C u r r e n t C a n d l e   =   P R E V I O U S _ C A N D L E   ;  
       m _ n L o t M a n a g e m e n t M e t h o d   =   E N U M _ L O T _ M A N A G E M E N T _ S L _ B E L O W _ S M V   ;  
       B r e a k E v e n P o i n t   =   3 5 ;   / /   i n   r o b o f o r e x   s p r e a d   i s   w i d e   2 5   p i p   ,   s o   B r e a k E v e n t   m u s t   h i g h e r  
       B a l a n c e R i s k V o l u m e   =   0 . 0 1 5 ; / / 0 . 0 1 5   ;   / / S t a n d a r d   M o n e y   M a n a g e m e n t   i s   M a x i m u m   R i s k   2 . 5 %  
  
       / * M V s M i n O p e n D i s t a n c e   =   3 1 0 ;  
       S l o w M V P e r i o d   =   5 0 ;  
       F a s t M V P e r i o d   =   3 0 ;  
       F a s t M V T y p e   =   M O D E _ L W M A ; * /  
  
 / / O t h e r s   C a u s e   T r a d e s C o u n t     d e c r e a s e   b e l o w   c r i t e r i a  
       m _ n O p e n O r d e r _ R i s k A n a l y s i s   =   E N U M _ O P E N O R D E R _ R I S K A N A L Y S I S _ R S I _ B A S E D ;  
       m _ n O p e n O r d e r _ R i s k A n a l y s i s _ R S I U p   =   8 7 ;  
       m _ n O p e n O r d e r _ R i s k A n a l y s i s _ R S I D o w n   =   1 7 ;  
       m _ n O p e n O r d e r _ R i s k A n a l y s i s _ D L B U p   =   9 2 ;  
       m _ n O p e n O r d e r _ R i s k A n a l y s i s _ D L B D o w n   =   6 ;  
  
  
       m _ n I n i t O r d e r S e t R u l e   =   E N U M _ I N I T O R D E R _ S E T _ A L L S P O T ;  
  
       i n t   n M V S t I n d e x   =   F i n d M V S t a t i s t i c s ( ) ;  
       M V s M a x C l o s e D i s t a n c e   =   n M V S t I n d e x > - 1   ?   ( i n t ) ( M a t h R o u n d ( o p t M V S t a t i s t i c s [ n M V S t I n d e x ] . m _ f M e a n   +   0 . 1   *   o p t M V S t a t i s t i c s [ n M V S t I n d e x ] . m _ f S t d ) )   :   4 0 ;  
  
 / / i n t e l l i g e n t   c a n   n o t   w o r k   ,   t h i s   i s   a n   s t a n d a r d   t o   s a v e   p r o f i t   ,   1 0 0 %   ,   2 0 0 %   v a   . . . .  
       A c t i v e B r e a k E v e n D i s t a n c e   =   E N U M _ B R E A K E V E N _ D I S A B L E D ;   / / E N U M _ B R E A K E V E N _ I N T E L L I G E N T ;   / / E N U M _ B R E A K E V E N _ R _ R _ 1 0 0   ;   / / O p t 2   D o n e   E f f e c t i v e  
       m _ n T a k e P r o f i t M e t h o d   =   E N U M _ T A K E P R O F I T _ M M _ R _ R ;  
       m _ f S t a t _ P r o f i t _ A v g   =   1 0 0 ;  
       m _ f S t a t _ P r o f i t _ S t d   =   9 0 ;  
 / / m _ n B r e a k E v e n _ I n t e l l i g e n t _ P i p D i s t a n c e _ A c t i v a t i o n   =     3 ;  
  
       P r o f i t T o T r a i l i n g S t o p   =   E N U M _ T R A I L I N G _ S T O P _ R S I _ S A T U R A T I O N ; / /   E N U M _ T R A I L I N G _ S T O P _ R S I _ S A T U R A T I O N   ;   / / 8 0   ;  
       T r a i l i n g S t o p M e t h o d   =   E N U M _ T R A I L I N G S T O P _ A T R ;   / / E N U M _ T R A I L I N G S T O P _ A T R 1 5   ;     / /  
 / / C h a n g e   F r o m   1 3   T o   2 1   ,   P o s i t i v e   I   t h o u g h t  
       T r a i l i n g P a r a m e t e r   =   1 3 ;   / /   3 0 ;  
 / / m _ n T r a i l i n g S t o p _ R S I _ O v e r S o l d L e v e l   &   m _ n T r a i l i n g S t o p _ R S I _ O v e r B o u g h t L e v e l   m u s t   b e   r a t i o n a l   a n d   l o g i c a l   n o t   o v e r f i t ,   O v e r S o l d   > =   1 0 0 - O v e r B o u g h t  
       m _ n T r a i l i n g S t o p _ R S I _ O v e r S o l d L e v e l   =   2 2 ;  
       m _ n T r a i l i n g S t o p _ R S I _ O v e r B o u g h t L e v e l   =   7 8 ;  
  
       m _ n S t o p L o s s T y p e   =   E N U M _ S T O P L O S S _ B E L O W _ C U S T O M _ M V _ C L O S E _ B A S E D ; / /   E N U M _ S T O P L O S S _ B E L O W _ S L O W _ M V ;   / / O p t 2   D o n e   E f f e c t i v e  
       m _ n S t o p L o s s P a r a m e t e r   =   S l o w M V P e r i o d   >   2 1   ?   S l o w M V P e r i o d   :   2 1 ;     / / O p t 2   D o n e   E f f e c t i v e  
 / / d e f a u l t   a f t e r   6 H o u r s   c l o s e   ,   n o t   u s e d   r e a l l y   b e c a u s e   o f   S i g n a l   M a C D  
       m _ n T i m e L i m i t _ S t o p L o s s   =   2 4 ;  
  
       O r d e r A s T r e n d   =   E N U M _ T R E N D _ H I G H E R _ T I M E F R A M E   ;   / / E N U M _ T R E N D _ D E T E R M I N E _ N O N E ; / /   E N U M _ T R E N D _ G O L D E N C R O S S   ;  
       m _ n H i g h e r T i m e F r a m e _ F a s t M V   =   9 ;   / / O P t 3   D o n e   E f f e c t i v e  
       m _ n H i g h e r T i m e F r a m e _ S l o w M V   =   2 6 ;   / / O P t 3   D o n e   E f f e c t i v e  
  
 / / i n   r o b o f o r e x   i n   1   y e a r   d a t a   s o m e   c a n d l e s   i s   v e r y   h i g h   n a v a s a n   ,   i n   o n e   t r a d e   I   b e c o m e   c a l l   m a r g i n   ,   n o t   a c c e p t a b l e ,  
 / /   I n   o n e   e x p e r i e n c e   s o   n e a r   t o   s t o p   l o s s   o r d e r   o p e n   ,   s o   h u g e   l o t   ,   a n d   I   b e c o m e   c a l l   m a r g i n  
       P a t i e n t T i m e   =   H u r y U p ;   / / O p t 1   D o n e   L i t t l e   E f f e c t  
 / / n o t   a n s w e r   R S I   a n d   ,   D I S A B L E   i s   s i m i l a r   t o   R S I _ C A N D L E S T I C K  
       m _ n B i g S t o p _ F i x e d L o t   =   f a l s e ;  
 / / m _ n H o u r s R e s t _ W h e n B i g L o s s   m u s t   s e t   w h e n   n o r m a l   c o n d i t i o n   a n d   P r o f i t   a n d   S t o p   L o s s   i s   r a t i o n a l   a n d   l o g i c a l .     N o w   o n l y   w a n t   f i n d   B e s t   O p e n   O r d e r   P o s i t i o n  
       m _ n H o u r s R e s t _ W h e n B i g L o s s   =   0 ;   / /   A d v i s e   a l l   M o n e y   M a n a g e m e n t   S y s t e m s   / / O P t 4   D o n e   L o w   E f f e c t  
       m _ f L o s s _ R i s k B a l a n c e _ R a t i o _ R e s t   =   2 . 0 ;                                                                       / / O P t 4   D o n e   N o t   E f f e c t  
       m _ n T i m e T r a d e M a n a g e r   =   E N U M _ T I M E _ T R A D E _ F R I D A Y _ A F T E R N O O N _ N O T _ O P E N   ;   / /   E N U M _ T I M E _ T R A D E _ H O L I D A Y _ O F F S E T   ;  
  
       m _ n A c t i v e S t a i r T r a d i n g M a n a g e m e n t   =     E N U M _ S T A I R T R A D I N G _ M A N A G E M E N T _ N O N E ;   / /   E N U M _ S T A I R T R A D I N G _ M A N A G E M E N T _ S T C _ C O M P E N S A T E   ;   / / E N U M _ S T A I R T R A D I N G _ M A N A G E M E N T _ S T C _ C O M P E N S A T E   ;   / / E N U M _ S T A I R T R A D I N G _ M A N A G E M E N T _ S T C _ C O M P E N S A T E ;  
       m _ n I s _ E x i t S i g n a l _ N o n M V M e t h o d   =   E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ S I G N A L ; / / E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ C A N D L E S T I C K _ A N D _ D I V E R G E N C E ; / / E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ D I S A B L E ;   / / E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ O N L Y _ D I V E R G E N C E ;   / /   E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ O N L Y _ D I V E R G E N C E ;  
       m _ n S i g n a l M A C D P e r i o d   =   1 2   ;  
  
 / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / /  
  
  
     }  
  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |                                                                                                                                     |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 v o i d   C E A P r o f i l e : : L o a d _ O p t i m i z a t i o n _ C l o s e O r d e r _ L e v e l 3 ( )  
     {  
  
 / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / /  
       S l o w M V T y p e   =   M O D E _ S M A ;  
       A c t i v e C l o s e O r d e r C u r r e n t C a n d l e   =   P R E V I O U S _ C A N D L E   ;  
       m _ n L o t M a n a g e m e n t M e t h o d   =   E N U M _ L O T _ M A N A G E M E N T _ S L _ B E L O W _ S M V   ;  
       B r e a k E v e n P o i n t   =   3 5 ;   / /   i n   r o b o f o r e x   s p r e a d   i s   w i d e   2 5   p i p   ,   s o   B r e a k E v e n t   m u s t   h i g h e r  
       B a l a n c e R i s k V o l u m e   =   0 . 0 1 8 ; / / 0 . 0 1 5   ;   / / S t a n d a r d   M o n e y   M a n a g e m e n t   i s   M a x i m u m   R i s k   2 . 5 %  
  
       / * M V s M i n O p e n D i s t a n c e   =   3 1 0 ;  
       S l o w M V P e r i o d   =   5 0 ;  
       F a s t M V P e r i o d   =   3 0 ;  
       F a s t M V T y p e   =   M O D E _ L W M A ; * /  
  
 / / O t h e r s   C a u s e   T r a d e s C o u n t     d e c r e a s e   b e l o w   c r i t e r i a  
       m _ n O p e n O r d e r _ R i s k A n a l y s i s   =   E N U M _ O P E N O R D E R _ R I S K A N A L Y S I S _ D L B _ B A S E D ;  
 / / m _ n O p e n O r d e r _ R i s k A n a l y s i s _ R S I U p   =   8 7 ;  
 / / m _ n O p e n O r d e r _ R i s k A n a l y s i s _ R S I D o w n   =   1 7 ;  
 / / m _ n O p e n O r d e r _ R i s k A n a l y s i s _ D L B U p   =   8 4 ;  
 / / m _ n O p e n O r d e r _ R i s k A n a l y s i s _ D L B D o w n   =   1 6 ;  
  
  
       m _ n I n i t O r d e r S e t R u l e   =   E N U M _ I N I T O R D E R _ S E T _ A L L S P O T ;  
  
       i n t   n M V S t I n d e x   =   F i n d M V S t a t i s t i c s ( ) ;  
 / / M V s M a x C l o s e D i s t a n c e   =   n M V S t I n d e x > - 1   ?   ( i n t ) ( 0 . 3   *   M a t h R o u n d ( o p t M V S t a t i s t i c s [ n M V S t I n d e x ] . m _ f M e a n ) )   :   2 0 ;  
  
  
 / / i n t e l l i g e n t   c a n   n o t   w o r k   ,   t h i s   i s   a n   s t a n d a r d   t o   s a v e   p r o f i t   ,   1 0 0 %   ,   2 0 0 %   v a   . . . .  
 / / A c t i v e B r e a k E v e n D i s t a n c e   =   E N U M _ B R E A K E V E N _ F I X E D _ N 2 ;   / / E N U M _ B R E A K E V E N _ I N T E L L I G E N T ;   / / E N U M _ B R E A K E V E N _ R _ R _ 1 0 0   ;   / / O p t 2   D o n e   E f f e c t i v e  
       m _ n T a k e P r o f i t M e t h o d   =   E N U M _ T A K E P R O F I T _ D I S A B L E D ; / / E N U M _ T A K E P R O F I T _ M M _ R _ R ;  
       m _ f S t a t _ P r o f i t _ A v g   =   9 1 ;  
       m _ f S t a t _ P r o f i t _ S t d   =   8 9 . 7 ;  
       m _ n B r e a k E v e n _ I n t e l l i g e n t _ P i p D i s t a n c e _ A c t i v a t i o n   =     4 0 ;  
  
       P r o f i t T o T r a i l i n g S t o p   =   E N U M _ T R A I L I N G _ S T O P _ R S I _ S A T U R A T I O N ; / /   E N U M _ T R A I L I N G _ S T O P _ R S I _ S A T U R A T I O N   ;   / / 8 0   ;  
       T r a i l i n g S t o p M e t h o d   =   E N U M _ T R A I L I N G S T O P _ A T R ;   / / E N U M _ T R A I L I N G S T O P _ A T R 1 5   ;     / /  
 / / C h a n g e   F r o m   1 3   T o   2 1   ,   P o s i t i v e   I   t h o u g h t  
 / / T r a i l i n g P a r a m e t e r   =   1 3 ;   / /   3 0 ;  
 / / m _ n T r a i l i n g S t o p _ R S I _ O v e r S o l d L e v e l   &   m _ n T r a i l i n g S t o p _ R S I _ O v e r B o u g h t L e v e l   m u s t   b e   r a t i o n a l   a n d   l o g i c a l   n o t   o v e r f i t ,   O v e r S o l d   > =   1 0 0 - O v e r B o u g h t  
 / / m _ n T r a i l i n g S t o p _ R S I _ O v e r S o l d L e v e l   =   2 4 ;  
 / / m _ n T r a i l i n g S t o p _ R S I _ O v e r B o u g h t L e v e l   =   7 0 ;  
  
       m _ n S t o p L o s s T y p e   =   E N U M _ S T O P L O S S _ B E L O W _ C U S T O M _ M V _ U P D A T E B L E _ C L O S E _ B A S E D ;   / /   E N U M _ S T O P L O S S _ B E L O W _ C U S T O M _ M V _ C L O S E _ B A S E D ; / /   E N U M _ S T O P L O S S _ B E L O W _ S L O W _ M V ;   / / O p t 2   D o n e   E f f e c t i v e  
 / / T r a d e O f f   B e t w e e n   M o r e   L o s s   ,   L i m i t   L o s s e s   ,   N o t   E f f e c t   O n   P r o f i t   A v e r a g e   O f   L o s s e d   a n d   S t d   ,   I n c r e a s e   W i n   R a t i o  
 / / L o s s C o u n t   L o w   a n d   A v g   L o w   ( T r a d e C o u n t   -   L o s s C o u n t ) / A v g L o s s  
       m _ n S t o p L o s s P a r a m e t e r   =   5 0 ;     / / O p t 2   D o n e   E f f e c t i v e  
 / / d e f a u l t   a f t e r   6 H o u r s   c l o s e   ,   n o t   u s e d   r e a l l y   b e c a u s e   o f   S i g n a l   M a C D  
       m _ n T i m e L i m i t _ S t o p L o s s   =   2 4 ;  
  
       O r d e r A s T r e n d   =   E N U M _ T R E N D _ H I G H E R _ T I M E F R A M E   ;   / / E N U M _ T R E N D _ D E T E R M I N E _ N O N E ; / /   E N U M _ T R E N D _ G O L D E N C R O S S   ;  
       m _ n H i g h e r T i m e F r a m e _ F a s t M V   =   9 ;   / / O P t 3   D o n e   E f f e c t i v e  
       m _ n H i g h e r T i m e F r a m e _ S l o w M V   =   2 1 ;   / / O P t 3   D o n e   E f f e c t i v e  
  
 / / i n   r o b o f o r e x   i n   1   y e a r   d a t a   s o m e   c a n d l e s   i s   v e r y   h i g h   n a v a s a n   ,   i n   o n e   t r a d e   I   b e c o m e   c a l l   m a r g i n   ,   n o t   a c c e p t a b l e ,  
 / /   I n   o n e   e x p e r i e n c e   s o   n e a r   t o   s t o p   l o s s   o r d e r   o p e n   ,   s o   h u g e   l o t   ,   a n d   I   b e c o m e   c a l l   m a r g i n  
       P a t i e n t T i m e   =   O n e C a n d l e I n M i d d l e ;   / / O p t 1   D o n e   L i t t l e   E f f e c t  
 / / n o t   a n s w e r   R S I   a n d   ,   D I S A B L E   i s   s i m i l a r   t o   R S I _ C A N D L E S T I C K  
       m _ n B i g S t o p _ F i x e d L o t   =   f a l s e ;  
 / / m _ n H o u r s R e s t _ W h e n B i g L o s s   m u s t   s e t   w h e n   n o r m a l   c o n d i t i o n   a n d   P r o f i t   a n d   S t o p   L o s s   i s   r a t i o n a l   a n d   l o g i c a l .     N o w   o n l y   w a n t   f i n d   B e s t   O p e n   O r d e r   P o s i t i o n  
       m _ n H o u r s R e s t _ W h e n B i g L o s s   =   2 4 ;   / /   A d v i s e   a l l   M o n e y   M a n a g e m e n t   S y s t e m s   / / O P t 4   D o n e   L o w   E f f e c t  
       m _ f L o s s _ R i s k B a l a n c e _ R a t i o _ R e s t   =   1 . 2 5 ;                                                                       / / O P t 4   D o n e   N o t   E f f e c t  
       m _ n T i m e T r a d e M a n a g e r   =   E N U M _ T I M E _ T R A D E _ H O L I D A Y _ O F F S E T _ F R I D A Y _ A F T E R N O O N _ N O T _ O P E N   ;   / /   E N U M _ T I M E _ T R A D E _ H O L I D A Y _ O F F S E T   ;  
  
       m _ n A c t i v e S t a i r T r a d i n g M a n a g e m e n t   =     E N U M _ S T A I R T R A D I N G _ M A N A G E M E N T _ N O N E ;   / /   E N U M _ S T A I R T R A D I N G _ M A N A G E M E N T _ S T C _ C O M P E N S A T E   ;   / / E N U M _ S T A I R T R A D I N G _ M A N A G E M E N T _ S T C _ C O M P E N S A T E   ;   / / E N U M _ S T A I R T R A D I N G _ M A N A G E M E N T _ S T C _ C O M P E N S A T E ;  
       m _ n I s _ E x i t S i g n a l _ N o n M V M e t h o d   =   E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ D I S A B L E ; / / E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ C A N D L E S T I C K _ A N D _ D I V E R G E N C E ; / / E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ D I S A B L E ;   / / E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ O N L Y _ D I V E R G E N C E ;   / /   E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ O N L Y _ D I V E R G E N C E ;  
       m _ n S i g n a l M A C D P e r i o d   =   1 2   ;  
  
     }  
  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |                                                                                                                                     |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 v o i d   C E A P r o f i l e : : L o a d _ O p t i m i z a t i o n _ D e t a i l O r d e r _ L e v e l 4 ( )  
     {  
       S l o w M V T y p e   =   M O D E _ S M A ;  
       A c t i v e C l o s e O r d e r C u r r e n t C a n d l e   =   P R E V I O U S _ C A N D L E   ;  
       m _ n L o t M a n a g e m e n t M e t h o d   =   E N U M _ L O T _ M A N A G E M E N T _ S L _ B E L O W _ S M V   ;  
       B r e a k E v e n P o i n t   =   2 0 ;   / /   i n   r o b o f o r e x   s p r e a d   i s   w i d e   2 5   p i p   ,   s o   B r e a k E v e n t   m u s t   h i g h e r  
       B a l a n c e R i s k V o l u m e   =   0 . 0 2 ; / / 0 . 0 1 5   ;   / / S t a n d a r d   M o n e y   M a n a g e m e n t   i s   M a x i m u m   R i s k   2 . 5 %  
  
  
       S l o w M V P e r i o d   =   5 0 ;  
       F a s t M V P e r i o d   =   9 ;  
       F a s t M V T y p e   =   M O D E _ L W M A ;  
       M V s M i n O p e n D i s t a n c e   =   2 5 0 ;  
  
  
       m _ n I n i t O r d e r S e t R u l e   =   E N U M _ I N I T O R D E R _ S E T _ A L L S P O T ;  
  
       M V s M a x C l o s e D i s t a n c e   =   1 5 0   ;  
       A c t i v e B r e a k E v e n D i s t a n c e   =   E N U M _ B R E A K E V E N _ I N T E L L I G E N T ; / / E N U M _ B R E A K E V E N _ I N T E L L I G E N T ;   / / E N U M _ B R E A K E V E N _ R _ R _ 1 0 0   ;  
       m _ n T a k e P r o f i t M e t h o d   =   E N U M _ T A K E P R O F I T _ D I S A B L E D ;  
       P r o f i t T o T r a i l i n g S t o p   =   E N U M _ T R A I L I N G _ S T O P _ R S I _ S A T U R A T I O N ; / /   E N U M _ T R A I L I N G _ S T O P _ R S I _ S A T U R A T I O N   ;   / / 8 0   ;  
       T r a i l i n g S t o p M e t h o d   =   E N U M _ T R A I L I N G S T O P _ A T R ;   / / E N U M _ T R A I L I N G S T O P _ A T R 1 5   ;     / /  
 / / C h a n g e   F r o m   1 3   T o   2 1   ,   P o s i t i v e   I   t h o u g h t  
       T r a i l i n g P a r a m e t e r   =   3 4 ;   / /   3 0 ;  
       m _ n I s _ E x i t S i g n a l _ N o n M V M e t h o d   =   E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ D I S A B L E ; / / E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ C A N D L E S T I C K _ A N D _ D I V E R G E N C E ; / / E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ D I S A B L E ;   / / E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ O N L Y _ D I V E R G E N C E ;   / /   E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ O N L Y _ D I V E R G E N C E ;  
       m _ n S i g n a l M A C D P e r i o d   =   1 2   ;  
       m _ n S t o p L o s s T y p e   =   E N U M _ S T O P L O S S _ B E L O W _ C U S T O M _ M V _ C L O S E _ B A S E D ; / /   E N U M _ S T O P L O S S _ B E L O W _ S L O W _ M V ;  
       m _ n S t o p L o s s P a r a m e t e r   =   1 2 ;  
       m _ n O p e n O r d e r _ R i s k A n a l y s i s   =   E N U M _ O P E N O R D E R _ R I S K A N A L Y S I S _ D I S A B L E ;  
       m _ n T i m e L i m i t _ S t o p L o s s   =   0 ;  
  
       O r d e r A s T r e n d   =   E N U M _ T R E N D _ H I G H E R _ T I M E F R A M E   ;   / / E N U M _ T R E N D _ D E T E R M I N E _ N O N E ; / /   E N U M _ T R E N D _ G O L D E N C R O S S   ;  
 / / i n   r o b o f o r e x   i n   1   y e a r   d a t a   s o m e   c a n d l e s   i s   v e r y   h i g h   n a v a s a n   ,   i n   o n e   t r a d e   I   b e c o m e   c a l l   m a r g i n   ,   n o t   a c c e p t a b l e ,  
 / /   I n   o n e   e x p e r i e n c e   s o   n e a r   t o   s t o p   l o s s   o r d e r   o p e n   ,   s o   h u g e   l o t   ,   a n d   I   b e c o m e   c a l l   m a r g i n  
       P a t i e n t T i m e   =   T w o C a n d l e I n M i d d l e ;  
 / / n o t   a n s w e r   R S I   a n d   ,   D I S A B L E   i s   s i m i l a r   t o   R S I _ C A N D L E S T I C K  
       m _ n A c t i v e S t a i r T r a d i n g M a n a g e m e n t   =     E N U M _ S T A I R T R A D I N G _ M A N A G E M E N T _ N O N E ;   / /   E N U M _ S T A I R T R A D I N G _ M A N A G E M E N T _ S T C _ C O M P E N S A T E   ;   / / E N U M _ S T A I R T R A D I N G _ M A N A G E M E N T _ S T C _ C O M P E N S A T E   ;   / / E N U M _ S T A I R T R A D I N G _ M A N A G E M E N T _ S T C _ C O M P E N S A T E ;  
       m _ n B i g S t o p _ F i x e d L o t   =   f a l s e ;  
       m _ n H o u r s R e s t _ W h e n B i g L o s s   =   3 6 ;   / /   A d v i s e   a l l   M o n e y   M a n a g e m e n t   S y s t e m s  
       m _ n T i m e T r a d e M a n a g e r   =   E N U M _ T I M E _ T R A D E _ H O L I D A Y _ O F F S E T _ F R I D A Y _ A F T E R N O O N _ N O T _ O P E N   ;   / /   E N U M _ T I M E _ T R A D E _ H O L I D A Y _ O F F S E T   ;  
       m _ f S t a t _ P r o f i t _ A v g   =   1 8 9 . 7 ;  
       m _ f S t a t _ P r o f i t _ S t d   =   2 9 4 . 2 ;  
     }  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |                                                                                                                                     |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 v o i d   C E A P r o f i l e : : L o a d _ O p t i m i z a t i o n _ D e t a i l O r d e r _ L e v e l 4 _ 2 ( )  
     {  
 / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / /  
       S l o w M V T y p e   =   M O D E _ S M A ;  
       A c t i v e C l o s e O r d e r C u r r e n t C a n d l e   =   P R E V I O U S _ C A N D L E   ;  
       m _ n L o t M a n a g e m e n t M e t h o d   =   E N U M _ L O T _ M A N A G E M E N T _ S L _ B E L O W _ S M V   ;  
       B r e a k E v e n P o i n t   =   3 5 ;   / /   i n   r o b o f o r e x   s p r e a d   i s   w i d e   2 5   p i p   ,   s o   B r e a k E v e n t   m u s t   h i g h e r  
 / /   C a n   b e   I n t e l l i g e n t   ? ? ?   P e r c e n t   D r a w   D o w n   N o t   D e t e r m i n e d  
       B a l a n c e R i s k V o l u m e   =   0 . 0 1 5 ; / / 0 . 0 1 5   ;   / / S t a n d a r d   M o n e y   M a n a g e m e n t   i s   M a x i m u m   R i s k   2 . 5 %  
  
       F a s t M V P e r i o d   =   3 0 ;  
       S l o w M V P e r i o d   =   5 0 ;  
       F a s t M V T y p e   =   M O D E _ L W M A ;  
 / / B e t w e e n   1 . 3   t o   1 . 7  
       i n t   n M V S t I n d e x   =   F i n d M V S t a t i s t i c s ( ) ;  
       P r i n t ( " L o a d _ S t a n d a r d   n M V S t I n d e x   " ,   n M V S t I n d e x ) ;  
       M V s M i n O p e n D i s t a n c e   =   ( n M V S t I n d e x > - 1   & &   F a s t M V T y p e   = =   M O D E _ L W M A )   ?   ( i n t ) ( M a t h R o u n d ( o p t M V S t a t i s t i c s [ n M V S t I n d e x ] . m _ f M e a n + 1 . 5 * o p t M V S t a t i s t i c s [ n M V S t I n d e x ] . m _ f S t d ) )   :   2 5 0 ;  
       M V s M i n O p e n D i s t a n c e   =   ( n M V S t I n d e x > - 1   & &   F a s t M V T y p e   = =   M O D E _ E M A )   ?   ( i n t ) ( M a t h R o u n d ( o p t M V S t a t i s t i c s [ n M V S t I n d e x ] . m _ f M e a n + 1 . 3 5 * o p t M V S t a t i s t i c s [ n M V S t I n d e x ] . m _ f S t d ) )   :   M V s M i n O p e n D i s t a n c e ;  
  
 / / O t h e r s   C a u s e   T r a d e s C o u n t     d e c r e a s e   b e l o w   c r i t e r i a  
       m _ n O p e n O r d e r _ R i s k A n a l y s i s   =   E N U M _ O P E N O R D E R _ R I S K A N A L Y S I S _ R S I _ B A S E D ;  
       m _ n O p e n O r d e r _ R i s k A n a l y s i s _ R S I U p   =   8 5 ;  
       m _ n O p e n O r d e r _ R i s k A n a l y s i s _ R S I D o w n   =   2 0 ;  
 / / m _ n O p e n O r d e r _ R i s k A n a l y s i s _ D L B U p   =   8 4 ;  
 / / m _ n O p e n O r d e r _ R i s k A n a l y s i s _ D L B D o w n   =   1 6 ;  
  
  
       m _ n I n i t O r d e r S e t R u l e   =   E N U M _ I N I T O R D E R _ S E T _ A L L S P O T ;  
  
 / / B e t w e e n   - 0 . 5   t o   0 . 5  
       M V s M a x C l o s e D i s t a n c e   =   ( n M V S t I n d e x > - 1   & &   F a s t M V T y p e   = =   M O D E _ E M A ) ?   ( i n t ) ( M a t h R o u n d ( o p t M V S t a t i s t i c s [ n M V S t I n d e x ] . m _ f M e a n + 0 . 1 * o p t M V S t a t i s t i c s [ n M V S t I n d e x ] . m _ f S t d ) )   :   8 0 ;  
       M V s M a x C l o s e D i s t a n c e   =   ( n M V S t I n d e x > - 1   & &   F a s t M V T y p e   = =   M O D E _ L W M A ) ?   ( i n t ) ( M a t h R o u n d ( o p t M V S t a t i s t i c s [ n M V S t I n d e x ] . m _ f M e a n + 0 . 1 * o p t M V S t a t i s t i c s [ n M V S t I n d e x ] . m _ f S t d ) )   :   M V s M a x C l o s e D i s t a n c e ;  
  
  
 / / i n   r o b o f o r e x   i n   1   y e a r   d a t a   s o m e   c a n d l e s   i s   v e r y   h i g h   n a v a s a n   ,   i n   o n e   t r a d e   I   b e c o m e   c a l l   m a r g i n   ,   n o t   a c c e p t a b l e ,  
 / /   I n   o n e   e x p e r i e n c e   s o   n e a r   t o   s t o p   l o s s   o r d e r   o p e n   ,   s o   h u g e   l o t   ,   a n d   I   b e c o m e   c a l l   m a r g i n  
       P a t i e n t T i m e   =   O n e C a n d l e I n M i d d l e ;   / / O p t 1   D o n e   L i t t l e   E f f e c t  
 / / i n t e l l i g e n t   c a n   n o t   w o r k   ,   t h i s   i s   a n   s t a n d a r d   t o   s a v e   p r o f i t   ,   1 0 0 %   ,   2 0 0 %   v a   . . . .  
       A c t i v e B r e a k E v e n D i s t a n c e   =   E N U M _ B R E A K E V E N _ I N T E L L I G E N T ;   / / E N U M _ B R E A K E V E N _ I N T E L L I G E N T ;   / / E N U M _ B R E A K E V E N _ R _ R _ 1 0 0   ;   / / O p t 2   D o n e   E f f e c t i v e  
       m _ n T a k e P r o f i t M e t h o d   =   E N U M _ T A K E P R O F I T _ M M _ R _ R ; / / E N U M _ T A K E P R O F I T _ M M _ R _ R ;  
       m _ f S t a t _ P r o f i t _ A v g   =   1 0 0 ;  
       m _ f S t a t _ P r o f i t _ S t d   =   8 0 ;  
       m _ n B r e a k E v e n _ I n t e l l i g e n t _ P i p D i s t a n c e _ A c t i v a t i o n   =     4 0 ;  
  
       P r o f i t T o T r a i l i n g S t o p   =   E N U M _ T R A I L I N G _ S T O P _ R S I _ S A T U R A T I O N ; / /   E N U M _ T R A I L I N G _ S T O P _ R S I _ S A T U R A T I O N   ;   / / 8 0   ;  
       T r a i l i n g S t o p M e t h o d   =   E N U M _ T R A I L I N G S T O P _ A T R ;   / / E N U M _ T R A I L I N G S T O P _ A T R 1 5   ;     / /  
 / / C h a n g e   F r o m   1 3   T o   2 1   ,   P o s i t i v e   I   t h o u g h t  
       T r a i l i n g P a r a m e t e r   =   1 3 ;   / /   3 0 ;  
 / / m _ n T r a i l i n g S t o p _ R S I _ O v e r S o l d L e v e l   &   m _ n T r a i l i n g S t o p _ R S I _ O v e r B o u g h t L e v e l   m u s t   b e   r a t i o n a l   a n d   l o g i c a l   n o t   o v e r f i t ,   O v e r S o l d   > =   1 0 0 - O v e r B o u g h t  
       m _ n T r a i l i n g S t o p _ R S I _ O v e r S o l d L e v e l   =   2 4 ;  
       m _ n T r a i l i n g S t o p _ R S I _ O v e r B o u g h t L e v e l   =   7 8 ;  
  
       m _ n S t o p L o s s T y p e   =   E N U M _ S T O P L O S S _ B E L O W _ C U S T O M _ M V _ C L O S E _ B A S E D ;   / /   E N U M _ S T O P L O S S _ B E L O W _ C U S T O M _ M V _ C L O S E _ B A S E D ; / /   E N U M _ S T O P L O S S _ B E L O W _ S L O W _ M V ;   / / O p t 2   D o n e   E f f e c t i v e  
 / / T r a d e O f f   B e t w e e n   M o r e   L o s s   ,   L i m i t   L o s s e s   ,   N o t   E f f e c t   O n   P r o f i t   A v e r a g e   O f   L o s s e d   a n d   S t d   ,   I n c r e a s e   W i n   R a t i o  
 / / L o s s C o u n t   L o w   a n d   A v g   L o w   ( T r a d e C o u n t   -   L o s s C o u n t ) / A v g L o s s  
  
       m _ n S t o p L o s s P a r a m e t e r   =   S l o w M V P e r i o d   >   2 1   ?   S l o w M V P e r i o d   :   2 1 ;     / / O p t 2   D o n e   E f f e c t i v e  
       m _ n S t o p L o s s P a r a m e t e r   =   S l o w M V P e r i o d   <   2 0   ?   H i g h e r P e r i o d _ N o r m a l M V ( S l o w M V P e r i o d )   :   S l o w M V P e r i o d ;     / / O p t 2   D o n e   E f f e c t i v e  
  
 / / d e f a u l t   a f t e r   6 H o u r s   c l o s e   ,   n o t   u s e d   r e a l l y   b e c a u s e   o f   S i g n a l   M a C D  
       m _ n T i m e L i m i t _ S t o p L o s s   =   2 4 ;  
  
       O r d e r A s T r e n d   =   E N U M _ T R E N D _ H I G H E R _ T I M E F R A M E   ;   / / E N U M _ T R E N D _ D E T E R M I N E _ N O N E ; / /   E N U M _ T R E N D _ G O L D E N C R O S S   ;  
       m _ n H i g h e r T i m e F r a m e _ F a s t M V   =   9 ;   / / O P t 3   D o n e   E f f e c t i v e  
       m _ n H i g h e r T i m e F r a m e _ S l o w M V   =   2 1 ;   / / O P t 3   D o n e   E f f e c t i v e  
  
 / / n o t   a n s w e r   R S I   a n d   ,   D I S A B L E   i s   s i m i l a r   t o   R S I _ C A N D L E S T I C K  
       m _ n B i g S t o p _ F i x e d L o t   =   f a l s e ;  
 / /  
 / / m _ n H o u r s R e s t _ W h e n B i g L o s s   m u s t   s e t   w h e n   n o r m a l   c o n d i t i o n   a n d   P r o f i t   a n d   S t o p   L o s s   i s   r a t i o n a l   a n d   l o g i c a l .     N o w   o n l y   w a n t   f i n d   B e s t   O p e n   O r d e r   P o s i t i o n  
       m _ n H o u r s R e s t _ W h e n B i g L o s s   =   3 6 ;   / /   A d v i s e   a l l   M o n e y   M a n a g e m e n t   S y s t e m s   / / O P t 4   D o n e   L o w   E f f e c t  
       m _ f L o s s _ R i s k B a l a n c e _ R a t i o _ R e s t   =   1 . 2 5 ;                                                                       / / O P t 4   D o n e   N o t   E f f e c t  
       m _ n T i m e T r a d e M a n a g e r   =   E N U M _ T I M E _ T R A D E _ F R I D A Y _ A F T E R N O O N _ N O T _ O P E N   ;   / /   E N U M _ T I M E _ T R A D E _ H O L I D A Y _ O F F S E T   ;  
  
       m _ n A c t i v e S t a i r T r a d i n g M a n a g e m e n t   =     E N U M _ S T A I R T R A D I N G _ M A N A G E M E N T _ N O N E ;   / /   E N U M _ S T A I R T R A D I N G _ M A N A G E M E N T _ S T C _ C O M P E N S A T E   ;   / / E N U M _ S T A I R T R A D I N G _ M A N A G E M E N T _ S T C _ C O M P E N S A T E   ;   / / E N U M _ S T A I R T R A D I N G _ M A N A G E M E N T _ S T C _ C O M P E N S A T E ;  
       m _ n I s _ E x i t S i g n a l _ N o n M V M e t h o d   =   E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ D I S A B L E ; / / E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ C A N D L E S T I C K _ A N D _ D I V E R G E N C E ; / / E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ D I S A B L E ;   / / E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ O N L Y _ D I V E R G E N C E ;   / /   E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ O N L Y _ D I V E R G E N C E ;  
       m _ n S i g n a l M A C D P e r i o d   =   1 2   ;  
  
     }  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |                                                                                                                                     |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 v o i d   C E A P r o f i l e : : L o a d _ S t a n d a r d ( )  
     {  
       / *  
       3 0   ,   5 0   L W M A   1  
       / *   E U R U S D   1 5   I N   E X I T _ S I G N A L   P r o f i t   S o r t  
       9   2 6 , 5 0 , M O D E _ L W M A , 1 . 7   - 5 0  
       1 0   3 0 , 5 0 , M O D E _ L W M A , 1 . 5   - 1 5 0  
       3 0 , 5 0 , M O D E _ L W M A , 1 . 6  
       3 0 , 5 0 , M O D E _ E M A , 1 . 6  
       1 1   3 4 , 5 0 , M O D E _ L W M A , 1 . 4  
       1   1 3 , 3 0 , M O D E _ E M A , 1 . 4  
       3   9 , 3 4 , M O D E _ L W M A , 1 . 7  
       4   1 3 , 3 0 , M O D E _ L W M A , 1 . 8  
       4   1 3 , 3 0 , M O D E _ E M A , 1 . 8   ? ?  
       9   2 6 , 5 0 , M O D E _ E M A , 1 . 5  
       0   9 , 3 0 , M O D E _ L W M A , 1 . 8  
       7   1 3 , 5 0 , M O D E _ L W M A , 1 . 7  
       5   2 1 , 3 4 , M O D E _ L W M A , 1 . 6  
       8   2 1 , 5 0 , M O D E _ L W M A , 1 . 4  
       1 0   3 0 , 5 0 , M O D E _ L W M A , 1 . 4  
       3   9 , 3 4 , M O D E _ L W M A , 1 . 5  
       6   2 6 , 3 4 , M O D E _ E M A , 1 . 7  
       2   2 1 , 3 0 , M O D E _ E M A , 1 . 7  
       4   1 3 , 3 4 , M O D E _ E M A , 1 . 8  
  
       / / W i n R a t i o   S o r t   E x i t   S i g n a l  
       9 , L W M A  
       1 0 , E M A , 1 . 6  
       6 , E M A , 1 . 7   I n t e r 1  
       6 , E M A , 1 . 3   I n t e r 1  
       1 , E M A , 1 . 3  
       1 1 , L W M A , 1 . 4   I n t e r 2  
       9 , L W M A , 1 . 6   I n t e r t i n g  
       1 1 , L W M A   1 . 8   I n t e r 2  
       S o m e   o f   T h e m   i s   N e a r   a n d   C o n t i n u a t i o n   B o t h   W o r k     H a v e   D i s t a n c e   ,   S o m e   o f   T h e m  
       N o t   F i x e d   R u l e   C a n   E x t r a c t   R e a l l y  
        
       / / I n C l o s e   S o r t   P r o f i t  
       1 0 , 3 , 1 . 5  
       1 1 , 3 , 1 . 3  
       1 0 , 3 , 1 . 7  
       1 1 , 3 , 1 . 6  
       8 , 3 , 1 . 5  
       1 1 , 3 , 1 . 4  
       1 1 , 3 , 1 . 7  
       1 1 , 1 , 1 . 6  
       1 0 , 1 , 1 . 6  
       8 , 1 , 1 . 6  
       7 , 1 , 1 . 5  
       1 1 , 1 , 1 . 5  
       7 , 3 , 1 . 5  
       8 , 1 , 1 . 4  
       8 , 1 , 1 . 7  
       9 , 1 , 1 . 5  
        
       S o r t   W i n R a t i o  
       1 1 , 1 , 1 . 6 , 0 . 5 7  
       7 , 3 , 1 . 5 , 5 7  
       3 , 1 , 1 . 5 , 0 . 5 5  
       1 0 , 1 , 1 . 6 , 0 . 5 5  
       1 1 , 3 , 1 . 7 , 0 . 5 5  
       8 , 1 , 1 . 7 , 0 . 5 5  
        
       / / L a s t T e s t   E U R U S D   S t o p L o s s   T a k e P r o f i t  
       { 1 0 , M O D E _ E M A , 1 . 6 } , E N U M _ S T O P L O S S _ B E L O W _ C U S T O M _ M V _ C L O S E _ B A S E D , 3 4 , E N U M _ T A K E P R O F I T _ M M _ R _ H R   ,   - 7 4 $ ,   1 6 0 T r a d e , 1 2 . 9 % D D  
       { 1 0 , M O D E _ L W M A , 1 . 7 } ,  
       { 1 0 , M O D E _ L W M A , 1 . 5 } ,  
       { 1 0 , M O D E _ E M A , 1 . 6 } , E N U M _ S T O P L O S S _ B E L O W _ C U S T O M _ M V _ C L O S E _ B A S E D , 5 0 , E N U M _ T A K E P R O F I T _ M M _ R _ H R   ,   - 8 0 $ ,   1 5 8 T r a d e , 1 2 . 1 8 % D D  
       { 1 0 , M O D E _ L W M A , 1 . 7 } ,  
       { 1 0 , M O D E _ L W M A , 1 . 5 } ,  
  
       / / W i n R a t i o   S o r t  
       { 1 1 , M O D E _ L W M A , 1 . 7 } , E N U M _ T A K E P R O F I T _ M M _ R _ R , E N U M _ S T O P L O S S _ B E L O W _ C U S T O M _ M V _ U P D A T E B L E , 5 0   ,   6 1 . 2 %   W i n R a t i o   ,   2 1 8 %   L o s s   ,   1 4 2   T r a d e s   ,   2 1 . 5 % D D  
       P r o b l e m   i s   C l o s e   O b v i o u s l y  
       { 1 1 , M O D E _ E M A , 1 . 6 } ,  
       { 1 1 , M O D E _ L W M A , 1 . 6 } ,  
       { 1 1 , M O D E _ L W M A , 1 . 3 } ,  
       O b v .   T K _ R R   b e t t e r   T K _ H R _ R   a n d   B e t t e r   D I S A B L E D  
       O b v .     E N U M _ S T O P L O S S _ B E L O W _ C U S T O M _ M V _ U P D A T E B L E , 5 0   i s   b e s t   f o r   W i n R a t i o   H i g h e s t  
       O b v .    
       * /  
     / *  
     4 7 4 3 	 P r : 1 1 8 5 . 2 2 	 1 4 2 	 1 . 0 2 	 8 . 3 5 	 2 1 3 8 4 . 0 4 	 1 5 . 7 4 % 	 0 . 2 4 6 3 7 6 8 1 	 p r M V O p e n O r d e r O p t i m i z e S e r i e s = 1   	 p r M V s M a x C l o s e D i s t a n c e = 8 0   	 p r A c t i v e B r e a k E v e n D i s t a n c e = 2 0   	 p _ n T a k e P r o f i t M e t h o d = - 2   	 p r S t o p L o s s T y p e = 6   	 p r S t o p L o s s P a r a m e t e r = 3 0   	 p _ n H i g h e r T i m e F r a m e _ F a s t M V = 9   	 p _ n H i g h e r T i m e F r a m e _ S l o w M V = 2 1 	 p r O p t i m i s e d P r o f i l e L o a d = 1   	 p r F a s t M V P e r i o d = 2 1   	 p r S l o w M V P e r i o d = 3 4   	 p r M V s M i n O p e n D i s t a n c e = 2 7   	 p r O r d e r A s T r e n d = 1   	 p r T r a i l i n g C o m b i n a t i o n P a r a m e t e r = - 1   	 p r O p t T s t B r T r D i s O p t i m i z a t i o n S e r i e s = - 1   	 p r P a t i e n t T i m e = 1   	 p r A c t i v e C l o s e O r d e r C u r r e n t C a n d l e = 1   	 p r B r e a k E v e n P o i n t = 5   	 p r T r a i l i n g S t o p M e t h o d = 5   	 p r P r o f i t T o T r a i l i n g S t o p = 1 0 0   	 p r T r a i l i n g P a r a m e t e r = 2 0   	 p r F a s t M V T y p e = 1   	 p r S l o w M V T y p e = 0   	 p r B a l a n c e R i s k V o l u m e = 0 . 0 5   	 p r M a n u a l T a k e P r o f i t = 0   	 p _ n O p e n O r d e r _ R i s k A n a l y s i s = 2   	 p _ n O p e n O r d e r _ R i s k A n a l y s i s _ L e v e l U p = 9 0   	 p _ n O p e n O r d e r _ R i s k A n a l y s i s _ L e v e l D o w n =  
 { 1 0 , M O D E _ L W M A , 1 . 7 } ,  
 4 1 7 1 	 1 1 8 5 . 2 2 	 1 4 2 	 1 . 0 2 	 8 . 3 5 	 2 1 3 8 4 . 0 4 	 1 5 . 7 4 % 	 0 . 2 4 6 3 7 6 8 1 	 p r M V O p e n O r d e r O p t i m i z e S e r i e s = 1   	 p r M V s M a x C l o s e D i s t a n c e = 8 0   	 p r A c t i v e B r e a k E v e n D i s t a n c e = - 2   	 p _ n T a k e P r o f i t M e t h o d = - 2   	 p r S t o p L o s s T y p e = 4   	 p r S t o p L o s s P a r a m e t e r = 3 0   	 p _ n H i g h e r T i m e F r a m e _ F a s t M V = 9   	 p _ n H i g h e r T i m e F r a m e _ S l o w M V = 2 1 	 p r O p t i m i s e d P r o f i l e L o a d = 1   	 p r F a s t M V P e r i o d = 2 1   	 p r S l o w M V P e r i o d = 3 4   	 p r M V s M i n O p e n D i s t a n c e = 2 7   	 p r O r d e r A s T r e n d = 1   	 p r T r a i l i n g C o m b i n a t i o n P a r a m e t e r = - 1   	 p r O p t T s t B r T r D i s O p t i m i z a t i o n S e r i e s = - 1   	 p r P a t i e n t T i m e = 1   	 p r A c t i v e C l o s e O r d e r C u r r e n t C a n d l e = 1   	 p r B r e a k E v e n P o i n t = 5   	 p r T r a i l i n g S t o p M e t h o d = 5   	 p r P r o f i t T o T r a i l i n g S t o p = 1 0 0   	 p r T r a i l i n g P a r a m e t e r = 2 0   	 p r F a s t M V T y p e = 1   	 p r S l o w M V T y p e = 0   	 p r B a l a n c e R i s k V o l u m e = 0 . 0 5   	 p r M a n u a l T a k e P r o f i t = 0   	 p _ n O p e n O r d e r _ R i s k A n a l y s i s = 2   	 p _ n O p e n O r d e r _ R i s k A n a l y s i s _ L e v e l U p = 9 0   	 p _ n O p e n O r d e r _ R i s k A n a l y s i s _ L e v e l D o w n =  
 4 2 1 5 	 1 1 8 5 . 2 2 	 1 4 2 	 1 . 0 2 	 8 . 3 5 	 2 1 3 8 4 . 0 4 	 1 5 . 7 4 % 	 0 . 2 4 6 3 7 6 8 1 	 p r M V O p e n O r d e r O p t i m i z e S e r i e s = 1   	 p r M V s M a x C l o s e D i s t a n c e = 8 0   	 p r A c t i v e B r e a k E v e n D i s t a n c e = 2 0   	 p _ n T a k e P r o f i t M e t h o d = - 2   	 p r S t o p L o s s T y p e = 4   	 p r S t o p L o s s P a r a m e t e r = 3 0   	 p _ n H i g h e r T i m e F r a m e _ F a s t M V = 9   	 p _ n H i g h e r T i m e F r a m e _ S l o w M V = 2 1 	 p r O p t i m i s e d P r o f i l e L o a d = 1   	 p r F a s t M V P e r i o d = 2 1   	 p r S l o w M V P e r i o d = 3 4   	 p r M V s M i n O p e n D i s t a n c e = 2 7   	 p r O r d e r A s T r e n d = 1   	 p r T r a i l i n g C o m b i n a t i o n P a r a m e t e r = - 1   	 p r O p t T s t B r T r D i s O p t i m i z a t i o n S e r i e s = - 1   	 p r P a t i e n t T i m e = 1   	 p r A c t i v e C l o s e O r d e r C u r r e n t C a n d l e = 1   	 p r B r e a k E v e n P o i n t = 5   	 p r T r a i l i n g S t o p M e t h o d = 5   	 p r P r o f i t T o T r a i l i n g S t o p = 1 0 0   	 p r T r a i l i n g P a r a m e t e r = 2 0   	 p r F a s t M V T y p e = 1   	 p r S l o w M V T y p e = 0   	 p r B a l a n c e R i s k V o l u m e = 0 . 0 5   	 p r M a n u a l T a k e P r o f i t = 0   	 p _ n O p e n O r d e r _ R i s k A n a l y s i s = 2   	 p _ n O p e n O r d e r _ R i s k A n a l y s i s _ L e v e l U p = 9 0   	 p _ n O p e n O r d e r _ R i s k A n a l y s i s _ L e v e l D o w n =  
 4 6 9 9 	 1 1 8 5 . 2 2 	 1 4 2 	 1 . 0 2 	 8 . 3 5 	 2 1 3 8 4 . 0 4 	 1 5 . 7 4 % 	 0 . 2 4 6 3 7 6 8 1 	 p r M V O p e n O r d e r O p t i m i z e S e r i e s = 1   	 p r M V s M a x C l o s e D i s t a n c e = 8 0   	 p r A c t i v e B r e a k E v e n D i s t a n c e = - 2   	 p _ n T a k e P r o f i t M e t h o d = - 2   	 p r S t o p L o s s T y p e = 6   	 p r S t o p L o s s P a r a m e t e r = 3 0   	 p _ n H i g h e r T i m e F r a m e _ F a s t M V = 9   	 p _ n H i g h e r T i m e F r a m e _ S l o w M V = 2 1 	 p r O p t i m i s e d P r o f i l e L o a d = 1   	 p r F a s t M V P e r i o d = 2 1   	 p r S l o w M V P e r i o d = 3 4   	 p r M V s M i n O p e n D i s t a n c e = 2 7   	 p r O r d e r A s T r e n d = 1   	 p r T r a i l i n g C o m b i n a t i o n P a r a m e t e r = - 1   	 p r O p t T s t B r T r D i s O p t i m i z a t i o n S e r i e s = - 1   	 p r P a t i e n t T i m e = 1   	 p r A c t i v e C l o s e O r d e r C u r r e n t C a n d l e = 1   	 p r B r e a k E v e n P o i n t = 5   	 p r T r a i l i n g S t o p M e t h o d = 5   	 p r P r o f i t T o T r a i l i n g S t o p = 1 0 0   	 p r T r a i l i n g P a r a m e t e r = 2 0   	 p r F a s t M V T y p e = 1   	 p r S l o w M V T y p e = 0   	 p r B a l a n c e R i s k V o l u m e = 0 . 0 5   	 p r M a n u a l T a k e P r o f i t = 0   	 p _ n O p e n O r d e r _ R i s k A n a l y s i s = 2   	 p _ n O p e n O r d e r _ R i s k A n a l y s i s _ L e v e l U p = 9 0   	 p _ n O p e n O r d e r _ R i s k A n a l y s i s _ L e v e l D o w n =  
  
 5 2 7 1 	 1 5 7 5 . 5 4 	 1 4 3 	 1 . 0 3 	 1 1 . 0 2 	 1 8 4 9 2 . 3 4 	 1 3 . 8 6 % 	 0 . 1 7 1 8 7 5 0 0 	 p r M V O p e n O r d e r O p t i m i z e S e r i e s = 1   	 p r M V s M a x C l o s e D i s t a n c e = 8 0   	 p r A c t i v e B r e a k E v e n D i s t a n c e = 2 0   	 p _ n T a k e P r o f i t M e t h o d = - 2   	 p r S t o p L o s s T y p e = 5   	 p r S t o p L o s s P a r a m e t e r = 3 4   	 p _ n H i g h e r T i m e F r a m e _ F a s t M V = 9   	 p _ n H i g h e r T i m e F r a m e _ S l o w M V = 2 1 	 p r O p t i m i s e d P r o f i l e L o a d = 1   	 p r F a s t M V P e r i o d = 2 1   	 p r S l o w M V P e r i o d = 3 4   	 p r M V s M i n O p e n D i s t a n c e = 2 7   	 p r O r d e r A s T r e n d = 1   	 p r T r a i l i n g C o m b i n a t i o n P a r a m e t e r = - 1   	 p r O p t T s t B r T r D i s O p t i m i z a t i o n S e r i e s = - 1   	 p r P a t i e n t T i m e = 1   	 p r A c t i v e C l o s e O r d e r C u r r e n t C a n d l e = 1   	 p r B r e a k E v e n P o i n t = 5   	 p r T r a i l i n g S t o p M e t h o d = 5   	 p r P r o f i t T o T r a i l i n g S t o p = 1 0 0   	 p r T r a i l i n g P a r a m e t e r = 2 0   	 p r F a s t M V T y p e = 1   	 p r S l o w M V T y p e = 0   	 p r B a l a n c e R i s k V o l u m e = 0 . 0 5   	 p r M a n u a l T a k e P r o f i t = 0   	 p _ n O p e n O r d e r _ R i s k A n a l y s i s = 2   	 p _ n O p e n O r d e r _ R i s k A n a l y s i s _ L e v e l U p = 9 0   	 p _ n O p e n O r d e r _ R i s k A n a l y s i s _ L e v e l D o w n =  
 5 2 2 7 	 1 5 7 5 . 5 4 	 1 4 3 	 1 . 0 3 	 1 1 . 0 2 	 1 8 4 9 2 . 3 4 	 1 3 . 8 6 % 	 0 . 1 7 1 8 7 5 0 0 	 p r M V O p e n O r d e r O p t i m i z e S e r i e s = 1   	 p r M V s M a x C l o s e D i s t a n c e = 8 0   	 p r A c t i v e B r e a k E v e n D i s t a n c e = - 2   	 p _ n T a k e P r o f i t M e t h o d = - 2   	 p r S t o p L o s s T y p e = 5   	 p r S t o p L o s s P a r a m e t e r = 3 4   	 p _ n H i g h e r T i m e F r a m e _ F a s t M V = 9   	 p _ n H i g h e r T i m e F r a m e _ S l o w M V = 2 1 	 p r O p t i m i s e d P r o f i l e L o a d = 1   	 p r F a s t M V P e r i o d = 2 1   	 p r S l o w M V P e r i o d = 3 4   	 p r M V s M i n O p e n D i s t a n c e = 2 7   	 p r O r d e r A s T r e n d = 1   	 p r T r a i l i n g C o m b i n a t i o n P a r a m e t e r = - 1   	 p r O p t T s t B r T r D i s O p t i m i z a t i o n S e r i e s = - 1   	 p r P a t i e n t T i m e = 1   	 p r A c t i v e C l o s e O r d e r C u r r e n t C a n d l e = 1   	 p r B r e a k E v e n P o i n t = 5   	 p r T r a i l i n g S t o p M e t h o d = 5   	 p r P r o f i t T o T r a i l i n g S t o p = 1 0 0   	 p r T r a i l i n g P a r a m e t e r = 2 0   	 p r F a s t M V T y p e = 1   	 p r S l o w M V T y p e = 0   	 p r B a l a n c e R i s k V o l u m e = 0 . 0 5   	 p r M a n u a l T a k e P r o f i t = 0   	 p _ n O p e n O r d e r _ R i s k A n a l y s i s = 2   	 p _ n O p e n O r d e r _ R i s k A n a l y s i s _ L e v e l U p = 9 0   	 p _ n O p e n O r d e r _ R i s k A n a l y s i s _ L e v e l D o w n =  
  
 * /  
 / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / /  
       S l o w M V T y p e   =   M O D E _ S M A ;  
       A c t i v e C l o s e O r d e r C u r r e n t C a n d l e   =   P R E V I O U S _ C A N D L E   ;  
       m _ n L o t M a n a g e m e n t M e t h o d   =   E N U M _ L O T _ M A N A G E M E N T _ S L _ B E L O W _ S M V   ;  
       B r e a k E v e n P o i n t   =   3 7 ;   / /   i n   r o b o f o r e x   s p r e a d   i s   w i d e   2 5   p i p   ,   s o   B r e a k E v e n t   m u s t   h i g h e r  
 / /   C a n   b e   I n t e l l i g e n t   ? ? ?   P e r c e n t   D r a w   D o w n   N o t   D e t e r m i n e d  
       B a l a n c e R i s k V o l u m e   =   0 . 0 1 5 ; / / 0 . 0 1 5   ;   / / S t a n d a r d   M o n e y   M a n a g e m e n t   i s   M a x i m u m   R i s k   2 . 5 %  
  
 / / F a s t M V P e r i o d   =   2 6 ;  
 / / S l o w M V P e r i o d   =   3 4 ;  
 / / F a s t M V T y p e   =   M O D E _ E M A ;  
 / / B e t w e e n   1 . 3   t o   1 . 7  
       i n t   n M V S t I n d e x   =   F i n d M V S t a t i s t i c s ( ) ;  
 / / d o u b l e   f M V D i s t a n c e   =   d o u b l e   ( S l o w M V P e r i o d   -   F a s t M V T y p e ) / 5 0 ;   / / B i g g e s t   S l o w   i s   5 0 ;  
 / / P r i n t ( " L o a d _ S t a n d a r d   n M V S t I n d e x   " ,   n M V S t I n d e x   ,   "   f M V D i s t a n c e   "   ,   f M V D i s t a n c e ) ;  
       d o u b l e   f C o e f   =   1 . 5 ;  
       / * i n t   n M V D i f f e r e n c e   =   ( S l o w M V P e r i o d   -   F a s t M V P e r i o d ) ;  
       i f ( F a s t M V P e r i o d < 2 0     & &   S l o w M V P e r i o d < 3 5 )  
           {  
             f C o e f   =   1 . 7 5 ;  
           }  
       e l s e  
             i f ( F a s t M V P e r i o d < 2 0     & &   S l o w M V P e r i o d > = 3 5 )  
                 {  
                   f C o e f   =   1 . 6 ;  
                 }  
             e l s e  
                   i f ( F a s t M V P e r i o d > = 2 0   & &   F a s t M V P e r i o d < 3 0 )  
                       {  
                         f C o e f   =   1 . 5 5 ;  
                       }  
                   e l s e  
                         i f ( F a s t M V P e r i o d > = 3 0 )  
                             {  
                               f C o e f   =   1 . 3 5 ;  
                             }  
       * /  
       M V s M i n O p e n D i s t a n c e   =   ( n M V S t I n d e x > - 1 )   ?   ( i n t ) ( M a t h R o u n d ( o p t M V S t a t i s t i c s [ n M V S t I n d e x ] . m _ f M e a n + m _ f S t d R a t i o * o p t M V S t a t i s t i c s [ n M V S t I n d e x ] . m _ f S t d ) )   :   2 5 0 ;  
  
 / / O t h e r s   C a u s e   T r a d e s C o u n t     d e c r e a s e   b e l o w   c r i t e r i a  
       m _ n O p e n O r d e r _ R i s k A n a l y s i s   =   E N U M _ O P E N O R D E R _ R I S K A N A L Y S I S _ R S I _ B A S E D ;  
       m _ n O p e n O r d e r _ R i s k A n a l y s i s _ R S I U p   =   8 5 ;  
       m _ n O p e n O r d e r _ R i s k A n a l y s i s _ R S I D o w n   =   2 0 ;  
 / / m _ n O p e n O r d e r _ R i s k A n a l y s i s _ D L B U p   =   8 4 ;  
 / / m _ n O p e n O r d e r _ R i s k A n a l y s i s _ D L B D o w n   =   1 6 ;  
  
  
       m _ n I n i t O r d e r S e t R u l e   =   E N U M _ I N I T O R D E R _ S E T _ A L L S P O T ;  
  
 / / B e t w e e n   - 0 . 5   t o   0 . 5  
       M V s M a x C l o s e D i s t a n c e   =   ( n M V S t I n d e x > - 1   & &   F a s t M V T y p e   = =   M O D E _ E M A ) ?   ( i n t ) ( o p t M V S t a t i s t i c s [ n M V S t I n d e x ] . m _ f M e a n )   :   8 0 ;  
       / / M V s M a x C l o s e D i s t a n c e   =   ( n M V S t I n d e x > - 1   & &   F a s t M V T y p e   = =   M O D E _ L W M A ) ?   ( i n t ) ( M a t h R o u n d ( o p t M V S t a t i s t i c s [ n M V S t I n d e x ] . m _ f M e a n + 0 . 1 * o p t M V S t a t i s t i c s [ n M V S t I n d e x ] . m _ f S t d ) )   :   M V s M a x C l o s e D i s t a n c e ;  
  
       m _ n S t o p L o s s T y p e   =   E N U M _ S T O P L O S S _ B E L O W _ C U S T O M _ M V _ U P D A T E B L E _ C L O S E _ B A S E D ;   / /   E N U M _ S T O P L O S S _ B E L O W _ C U S T O M _ M V _ C L O S E _ B A S E D ; / /   E N U M _ S T O P L O S S _ B E L O W _ S L O W _ M V ;   / / O p t 2   D o n e   E f f e c t i v e  
 / / T r a d e O f f   B e t w e e n   M o r e   L o s s   ,   L i m i t   L o s s e s   ,   N o t   E f f e c t   O n   P r o f i t   A v e r a g e   O f   L o s s e d   a n d   S t d   ,   I n c r e a s e   W i n   R a t i o  
 / / L o s s C o u n t   L o w   a n d   A v g   L o w   ( T r a d e C o u n t   -   L o s s C o u n t ) / A v g L o s s  
  
       m _ n S t o p L o s s P a r a m e t e r   =   S l o w M V P e r i o d   > =   2 0   ?   S l o w M V P e r i o d   :   2 1 ;     / / O p t 2   D o n e   E f f e c t i v e  
       m _ n S t o p L o s s P a r a m e t e r   =   S l o w M V P e r i o d   <   2 0   ?   H i g h e r P e r i o d _ N o r m a l M V ( S l o w M V P e r i o d )   :   S l o w M V P e r i o d ;     / / O p t 2   D o n e   E f f e c t i v e  
  
 / / d e f a u l t   a f t e r   6 H o u r s   c l o s e   ,   n o t   u s e d   r e a l l y   b e c a u s e   o f   S i g n a l   M a C D  
       m _ n T i m e L i m i t _ S t o p L o s s   =   2 4 ;  
  
 / / i n   r o b o f o r e x   i n   1   y e a r   d a t a   s o m e   c a n d l e s   i s   v e r y   h i g h   n a v a s a n   ,   i n   o n e   t r a d e   I   b e c o m e   c a l l   m a r g i n   ,   n o t   a c c e p t a b l e ,  
 / /   I n   o n e   e x p e r i e n c e   s o   n e a r   t o   s t o p   l o s s   o r d e r   o p e n   ,   s o   h u g e   l o t   ,   a n d   I   b e c o m e   c a l l   m a r g i n  
       P a t i e n t T i m e   =   O n e C a n d l e I n M i d d l e ;   / / O p t 1   D o n e   L i t t l e   E f f e c t  
 / / i n t e l l i g e n t   c a n   n o t   w o r k   ,   t h i s   i s   a n   s t a n d a r d   t o   s a v e   p r o f i t   ,   1 0 0 %   ,   2 0 0 %   v a   . . . .  
       / / A c t i v e B r e a k E v e n D i s t a n c e   =   E N U M _ B R E A K E V E N _ I N T E L L I G E N T ;   / / E N U M _ B R E A K E V E N _ I N T E L L I G E N T ;   / / E N U M _ B R E A K E V E N _ R _ R _ 1 0 0   ;   / / O p t 2   D o n e   E f f e c t i v e  
  
       m _ n T a k e P r o f i t M e t h o d   =   E N U M _ T A K E P R O F I T _ M M _ R _ R ;  
       m _ f S t a t _ P r o f i t _ A v g   =   1 0 0 ;  
       m _ f S t a t _ P r o f i t _ S t d   =   8 0 ;  
       m _ n B r e a k E v e n _ I n t e l l i g e n t _ P i p D i s t a n c e _ A c t i v a t i o n   =     4 0 ;  
  
       P r o f i t T o T r a i l i n g S t o p   =   E N U M _ T R A I L I N G _ S T O P _ R S I _ S A T U R A T I O N ; / /   E N U M _ T R A I L I N G _ S T O P _ R S I _ S A T U R A T I O N   ;   / / 8 0   ;  
       T r a i l i n g S t o p M e t h o d   =   E N U M _ T R A I L I N G S T O P _ A T R ;   / / E N U M _ T R A I L I N G S T O P _ A T R 1 5   ;     / /  
 / / C h a n g e   F r o m   1 3   T o   2 1   ,   P o s i t i v e   I   t h o u g h t  
       T r a i l i n g P a r a m e t e r   =   1 3 ;   / /   3 0 ;  
 / / m _ n T r a i l i n g S t o p _ R S I _ O v e r S o l d L e v e l   &   m _ n T r a i l i n g S t o p _ R S I _ O v e r B o u g h t L e v e l   m u s t   b e   r a t i o n a l   a n d   l o g i c a l   n o t   o v e r f i t ,   O v e r S o l d   > =   1 0 0 - O v e r B o u g h t  
       m _ n T r a i l i n g S t o p _ R S I _ O v e r S o l d L e v e l   =   2 4 ;  
       m _ n T r a i l i n g S t o p _ R S I _ O v e r B o u g h t L e v e l   =   7 8 ;  
  
  
       O r d e r A s T r e n d   =   E N U M _ T R E N D _ H I G H E R _ T I M E F R A M E   ;   / / E N U M _ T R E N D _ D E T E R M I N E _ N O N E ; / /   E N U M _ T R E N D _ G O L D E N C R O S S   ;  
       m _ n H i g h e r T i m e F r a m e _ F a s t M V   =   9 ;   / / O P t 3   D o n e   E f f e c t i v e  
       m _ n H i g h e r T i m e F r a m e _ S l o w M V   =   2 1 ;   / / O P t 3   D o n e   E f f e c t i v e  
  
 / / n o t   a n s w e r   R S I   a n d   ,   D I S A B L E   i s   s i m i l a r   t o   R S I _ C A N D L E S T I C K  
       m _ n B i g S t o p _ F i x e d L o t   =   f a l s e ;  
 / /  
 / / m _ n H o u r s R e s t _ W h e n B i g L o s s   m u s t   s e t   w h e n   n o r m a l   c o n d i t i o n   a n d   P r o f i t   a n d   S t o p   L o s s   i s   r a t i o n a l   a n d   l o g i c a l .     N o w   o n l y   w a n t   f i n d   B e s t   O p e n   O r d e r   P o s i t i o n  
       m _ n H o u r s R e s t _ W h e n B i g L o s s   =   3 6 ;   / /   A d v i s e   a l l   M o n e y   M a n a g e m e n t   S y s t e m s   / / O P t 4   D o n e   L o w   E f f e c t  
       m _ f L o s s _ R i s k B a l a n c e _ R a t i o _ R e s t   =   1 . 2 5 ;                                                                       / / O P t 4   D o n e   N o t   E f f e c t  
       m _ n T i m e T r a d e M a n a g e r   =   E N U M _ T I M E _ T R A D E _ F R I D A Y _ A F T E R N O O N _ N O T _ O P E N   ;   / /   E N U M _ T I M E _ T R A D E _ H O L I D A Y _ O F F S E T   ;  
  
       m _ n A c t i v e S t a i r T r a d i n g M a n a g e m e n t   =     E N U M _ S T A I R T R A D I N G _ M A N A G E M E N T _ N O N E ;   / /   E N U M _ S T A I R T R A D I N G _ M A N A G E M E N T _ S T C _ C O M P E N S A T E   ;   / / E N U M _ S T A I R T R A D I N G _ M A N A G E M E N T _ S T C _ C O M P E N S A T E   ;   / / E N U M _ S T A I R T R A D I N G _ M A N A G E M E N T _ S T C _ C O M P E N S A T E ;  
       m _ n I s _ E x i t S i g n a l _ N o n M V M e t h o d   =   E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ D I S A B L E ; / / E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ C A N D L E S T I C K _ A N D _ D I V E R G E N C E ; / / E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ D I S A B L E ;   / / E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ O N L Y _ D I V E R G E N C E ;   / /   E N U M _ E X I T S I G N A L _ N O N M V _ M E T H O D _ O N L Y _ D I V E R G E N C E ;  
       m _ n S i g n a l M A C D P e r i o d   =   1 2   ;  
  
     }  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |                                                                                                                                     |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 v o i d   C E A P r o f i l e : : L o a d P r o f i l e ( s t r i n g   s t r S y m b o l ,   i n t   n T i m e F r a m e )  
     {  
       C o p y O r i g i n a l P a r a m e t e r s ( ) ;  
       L o a d T e s t P a r a m e t e r s ( ) ;  
 / / / / / / / / / / / / / / / / / / / / / / /  
       i f ( p r O p t i m i s e d P r o f i l e L o a d )  
           {  
             L o a d S p e c i a l S y m b o l _ P a r a m e t e r s ( s t r S y m b o l ,   n T i m e F r a m e ) ;  
           }  
       i f ( ! I S _ S E C U R E )  
           {  
             s t r i n g   r o w   =   S t r i n g F o r m a t ( " L o a d P r o f i l e   % d ; % d ; % s ; % s ; % d ; % d ; % s ; % d " ,  
                                                                 F a s t M V P e r i o d , S l o w M V P e r i o d , E n u m T o S t r i n g ( F a s t M V T y p e ) , E n u m T o S t r i n g ( S l o w M V T y p e ) ,  
                                                                 M V s M i n O p e n D i s t a n c e , M V s M a x C l o s e D i s t a n c e , E n u m T o S t r i n g ( m _ n S t o p L o s s T y p e ) , m _ n S t o p L o s s P a r a m e t e r ) ;  
             P r i n t ( " L o a d P r o f i l e   "   +   r o w ) ;  
             r o w   =   S t r i n g F o r m a t ( " L o a d P r o f i l e   % s ; % s ; % s ; % s ; % d ; % s ; % d ; % s ; " , E n u m T o S t r i n g ( A c t i v e C l o s e O r d e r C u r r e n t C a n d l e ) ,  
                                                   E n u m T o S t r i n g ( O r d e r A s T r e n d ) , E n u m T o S t r i n g ( P a t i e n t T i m e ) , E n u m T o S t r i n g ( A c t i v e B r e a k E v e n D i s t a n c e ) ,  
                                                   P r o f i t T o T r a i l i n g S t o p , E n u m T o S t r i n g ( T r a i l i n g S t o p M e t h o d ) , T r a i l i n g P a r a m e t e r ,  
                                                   E n u m T o S t r i n g ( m _ n I s _ E x i t S i g n a l _ N o n M V M e t h o d ) ) ;  
             P r i n t ( " L o a d P r o f i l e   "   +   r o w ) ;  
  
             r o w   =   S t r i n g F o r m a t ( " L o a d P r o f i l e   % s ; % d ; % s ; % f ; % f " , E n u m T o S t r i n g ( m _ n A c t i v e S t a i r T r a d i n g M a n a g e m e n t ) ,  
                                                   B r e a k E v e n P o i n t , B o o l T o S t r ( m _ n B i g S t o p _ F i x e d L o t ) , m _ f S t a t _ P r o f i t _ A v g , m _ f S t a t _ P r o f i t _ S t d ) ;  
             P r i n t ( " L o a d P r o f i l e   "   +   r o w ) ;  
  
           }  
     }  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |                                                                                                                                     |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 v o i d   C E A P r o f i l e : : L o a d T e s t P a r a m e t e r s ( )  
     {  
       i f ( p r T r a i l i n g C o m b i n a t i o n P a r a m e t e r   > =   0   & &   p r T r a i l i n g C o m b i n a t i o n P a r a m e t e r   <   t r a i l P a r a m s A r r a y _ S i z e )  
           {  
             T r a i l i n g S t o p M e t h o d   =   t r a i l P a r a m s [ p r T r a i l i n g C o m b i n a t i o n P a r a m e t e r ] . T y p e   ;  
             T r a i l i n g P a r a m e t e r   =   t r a i l P a r a m s [ p r T r a i l i n g C o m b i n a t i o n P a r a m e t e r ] . n P a r a m V a l   ;  
           }  
 / / W h e n   B e s t   M V   i s   d e t e r m i n e d  
  
  
       i f ( m _ n O p t i m i z a t i o n L e v e l   ! =   E N U M _ O P T I M I Z A T I O N _ O P E N O R D E R _ 1   & &   m _ n O p t i m i z a t i o n L e v e l   ! =   E N U M _ O P T I M I Z A T I O N _ S T A T I S T I C S   & &   m _ n O p t i m i z a t i o n L e v e l   ! =   E N U M _ O P T I M I Z A T I O N _ S T O P L O S S _ O P T M V _ V 2   & &   p r M V O p e n O r d e r O p t i m i z e S e r i e s   > =   0   & &   p r M V O p e n O r d e r O p t i m i z e S e r i e s   <   A r r a y S i z e ( o p t M v s ) )  
           {  
             F a s t M V P e r i o d   =   o p t M v s [ p r M V O p e n O r d e r O p t i m i z e S e r i e s ] . F a s t P e r i o d ;  
             S l o w M V P e r i o d   =   o p t M v s [ p r M V O p e n O r d e r O p t i m i z e S e r i e s ] . S l o w P e r i o d ;  
             i f ( m _ n O p t i m i z a t i o n L e v e l   ! = E N U M _ O P T I M I Z A T I O N _ O P E N O R D E R _ O P E N D I S T A N C E _ F A S T M E T H O D _ D E T )  
                   F a s t M V T y p e   =   o p t M v s [ p r M V O p e n O r d e r O p t i m i z e S e r i e s ] . F a s t M e t h o d ;  
             / / S l o w M V T y p e   =   o p t M v s [ p r M V O p e n O r d e r O p t i m i z e S e r i e s ] . S l o w M e t h o d ;  
             i f ( m _ n O p t i m i z a t i o n L e v e l   ! = E N U M _ O P T I M I Z A T I O N _ O P E N O R D E R _ O P E N D I S T A N C E _ D E T   & &  
                   m _ n O p t i m i z a t i o n L e v e l   ! = E N U M _ O P T I M I Z A T I O N _ O P E N O R D E R _ O P E N D I S T A N C E _ F A S T M E T H O D _ D E T )  
                 {  
                   M V s M i n O p e n D i s t a n c e   =   o p t M v s [ p r M V O p e n O r d e r O p t i m i z e S e r i e s ] . M i n O p e n D i s t a n c e ;  
                   / / A c t i v e C l o s e O r d e r C u r r e n t C a n d l e   =   o p t M v s [ p r M V O p e n O r d e r O p t i m i z e S e r i e s ] . A p p l i e d P r i c e ;  
                   m _ f S t d R a t i o   =   o p t M v s [ p r M V O p e n O r d e r O p t i m i z e S e r i e s ] . f S t d R a t i o ;  
  
                 }  
             i f ( m _ n O p t i m i z a t i o n L e v e l   = =   E N U M _ O P T I M I Z A T I O N _ D E T A I L S _ 1 )  
                 {  
                   M V s M a x C l o s e D i s t a n c e   =   o p t M v s [ p r M V O p e n O r d e r O p t i m i z e S e r i e s ] . S u i t a b l e C l o s e D i s t a n c e ;  
                 }  
             i f ( m _ n O p t i m i z a t i o n L e v e l   = =   E N U M _ O P T I M I Z A T I O N _ C L O S E O R D E R _ C L O S E _ D I S )  
                 {  
                   m _ n S t o p L o s s T y p e   =   o p t M v s [ p r M V O p e n O r d e r O p t i m i z e S e r i e s ] . n S t o p L o s s T y p e ;  
                   / / m _ n S t o p L o s s P a r a m e t e r   =   o p t M v s [ p r M V O p e n O r d e r O p t i m i z e S e r i e s ] . n S t o p L o s s P a r a m e t e r ;  
                   A c t i v e B r e a k E v e n D i s t a n c e   =   o p t M v s [ p r M V O p e n O r d e r O p t i m i z e S e r i e s ] . n A c t i v e B r e a k E v e n D i s t a n c e ;  
                   M V s M a x C l o s e D i s t a n c e   =   o p t M v s [ p r M V O p e n O r d e r O p t i m i z e S e r i e s ] . S u i t a b l e C l o s e D i s t a n c e ;  
                   m _ n T a k e P r o f i t M e t h o d   =   o p t M v s [ p r M V O p e n O r d e r O p t i m i z e S e r i e s ] . n T a k e P r o f i t M e t h o d ;  
                   m _ n O p e n O r d e r _ R i s k A n a l y s i s   =   o p t M v s [ p r M V O p e n O r d e r O p t i m i z e S e r i e s ] . n O p e n O r d e r R i s k A n a l y s i s ;  
                   i f ( m _ n O p e n O r d e r _ R i s k A n a l y s i s   = =   E N U M _ O P E N O R D E R _ R I S K A N A L Y S I S _ D L B _ B A S E D )  
                       {  
                         m _ n O p e n O r d e r _ R i s k A n a l y s i s _ D L B U p   = o p t M v s [ p r M V O p e n O r d e r O p t i m i z e S e r i e s ] . n O p e n O r d e r _ R i s k A n a l y s i s _ L e v e l U p ;  
                         m _ n O p e n O r d e r _ R i s k A n a l y s i s _ D L B D o w n = o p t M v s [ p r M V O p e n O r d e r O p t i m i z e S e r i e s ] . n O p e n O r d e r _ R i s k A n a l y s i s _ L e v e l D o w n ;  
                       }  
                   e l s e  
                       {  
                         m _ n O p e n O r d e r _ R i s k A n a l y s i s _ R S I U p   = o p t M v s [ p r M V O p e n O r d e r O p t i m i z e S e r i e s ] . n O p e n O r d e r _ R i s k A n a l y s i s _ L e v e l U p ;  
                         m _ n O p e n O r d e r _ R i s k A n a l y s i s _ R S I D o w n = o p t M v s [ p r M V O p e n O r d e r O p t i m i z e S e r i e s ] . n O p e n O r d e r _ R i s k A n a l y s i s _ L e v e l D o w n ;  
                       }  
  
                 }  
  
           }  
 / / U s e d   W h e n   O p e n   O r d e r   O p t i m i z a t i o n  
       i f ( ( m _ n O p t i m i z a t i o n L e v e l   = =   E N U M _ O P T I M I Z A T I O N _ O P E N O R D E R _ 1   | |   m _ n O p t i m i z a t i o n L e v e l   = =   E N U M _ O P T I M I Z A T I O N _ S T A T I S T I C S )   & &   p r M V O p e n O r d e r O p t i m i z e S e r i e s   > =   0   & &   p r M V O p e n O r d e r O p t i m i z e S e r i e s   <   A r r a y S i z e ( o p t M V P e r i o d s ) )  
           {  
             F a s t M V P e r i o d   =   o p t M V P e r i o d s [ p r M V O p e n O r d e r O p t i m i z e S e r i e s ] . F a s t M B V P e r i o d ;  
             S l o w M V P e r i o d   =   o p t M V P e r i o d s [ p r M V O p e n O r d e r O p t i m i z e S e r i e s ] . S l o w M V P e r i o d ;  
           }  
     i f ( m _ n O p t i m i z a t i o n L e v e l   = = E N U M _ O P T I M I Z A T I O N _ S T O P L O S S _ O P T M V _ V 2   & &   p r M V O p e n O r d e r O p t i m i z e S e r i e s   > =   0   & &   p r M V O p e n O r d e r O p t i m i z e S e r i e s   <   A r r a y S i z e ( o p t M v s V 2 ) )  
           {  
             i n t   n I n d e x   =   o p t M v s V 2 [   p r M V O p e n O r d e r O p t i m i z e S e r i e s ] . n M V P e r i o d I n d e x ;  
             F a s t M V P e r i o d   =   o p t M V P e r i o d s [ n I n d e x ] . F a s t M B V P e r i o d ;  
             S l o w M V P e r i o d   =   o p t M V P e r i o d s [ n I n d e x ] . S l o w M V P e r i o d ;  
             F a s t M V T y p e   =   o p t M v s V 2 [ p r M V O p e n O r d e r O p t i m i z e S e r i e s ] . F a s t M e t h o d ;  
             m _ f S t d R a t i o   =   o p t M v s V 2 [ p r M V O p e n O r d e r O p t i m i z e S e r i e s ] . f S t d R a t i o ;  
           }  
       i f ( I S _ E N A B L E _ L O G   & &   ! I S _ S E C U R E )  
             P r i n t ( " L o a d A r r a y s   o p t M V P e r i o d s   S i z e   :   " , A r r a y S i z e ( o p t M V P e r i o d s ) ) ;  
  
  
       i f ( p r O p t T s t B r T r D i s O p t i m i z a t i o n S e r i e s   > =   0   & &   p r O p t T s t B r T r D i s O p t i m i z a t i o n S e r i e s   <   o p t B r T r D i s _ S i z e )  
           {  
             / / A c t i v e B r e a k E v e n D i s t a n c e   =   o p t B r T r D i s [ p r O p t T s t B r T r D i s O p t i m i z a t i o n S e r i e s ] . B r e a k e E v e n D i s ;  
             / / P r o f i t T o T r a i l i n g S t o p   =   o p t B r T r D i s [ p r O p t T s t B r T r D i s O p t i m i z a t i o n S e r i e s ] . T r a i l i n g D i s ;  
           }  
  
     }  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 / / |                                                                                                                                     |  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 v o i d   C E A P r o f i l e : : L o a d S p e c i a l S y m b o l _ P a r a m e t e r s ( s t r i n g   s t r S y m b o l ,   i n t   n T i m e F r a m e )  
     {  
       i n t   p o s   =   - 1 ,   S y m b o l I n d e x   =   - 1 ;  
       s t r i n g   S y m b o l s [ ]   =   {   " E U R U S D " ,   " G B P U S D " ,   " X A U U S D " ,   " A U D U S D " ,   " U S D J P Y " ,   " U S D C A D " ,   " X A G U S D " } ;  
       f o r ( i n t   i = 0 ;   i   < A r r a y S i z e ( S y m b o l s )   ;   i + + )  
           {  
             p o s   =   S t r i n g F i n d ( s t r S y m b o l , S y m b o l s [ i ] ) ;  
             i f ( p o s   >   - 1 )  
                 {  
                   S y m b o l I n d e x   =   i ;  
                   b r e a k ;  
                 }  
           }  
 / / i f ( ! I S _ S E C U R E )  
       P r i n t ( " L o a d S p e c i a l S y m b o l _ P a r a m e t e r s   "   ,   s t r S y m b o l   ,   "   "   ,   n T i m e F r a m e ) ;  
       P r i n t ( " L o a d S p e c i a l S y m b o l _ P a r a m e t e r s   " ,   S y m b o l s [ S y m b o l I n d e x ] ,   "   " ,   n T i m e F r a m e ) ;  
  
       s w i t c h ( S y m b o l I n d e x )  
           {  
             c a s e   0   :   / / E U R U S D  
                   s w i t c h ( n T i m e F r a m e )  
                       {  
                         c a s e   1 5   :  
                               L o a d _ E U R U S D _ 1 5 ( ) ;  
                               / / L o a d _ O p t i m i z a t i o n _ O p e n O r d e r _ L e v e l 1 ( ) ;  
                               / / L o a d _ O p t i m i z a t i o n _ D e t a i l O r d e r _ L e v e l 4 _ 2 ( ) ;  
                               / / L o a d _ O p t i m i z a t i o n _ C l o s e O r d e r _ L e v e l 3 ( ) ;  
                               / / L o a d _ S t a n d a r d ( ) ;  
                               / / L o a d _ O p t i m i z a t i o n _ D e t a i l O r d e r _ L e v e l 4 _ 2 ( ) ;  
                               b r e a k ;  
                         c a s e   6 0 :  
                               L o a d _ E U R U S D _ 6 0 ( ) ;  
                               b r e a k ;  
                       }  
                   b r e a k ;  
             c a s e   1   :   / / G B P U S D   F a s t   3   , S l o w   5 0   , M i n   2 4   , T h r e s h o l d   C l o s e   2 4   ,   G O L D E N _ C R O S S   ,   P r o f i t   $ 2 1 5 4   ,   O n T e s t e r   0 . 0 5 5  
                   s w i t c h ( P e r i o d ( ) )  
                       {  
                         c a s e   1 5   :  
                               L o a d _ G B P U S D _ 1 5 ( ) ;  
                               / / L o a d _ O p t i m i z a t i o n _ O p e n O r d e r _ L e v e l 1 ( ) ;  
                               / / L o a d _ O p t i m i z a t i o n _ C l o s e O r d e r _ L e v e l 3 ( ) ;  
                               b r e a k ;  
                         c a s e   6 0 :  
                               L o a d _ G B P U S D _ 6 0 ( ) ;  
                               b r e a k ;  
                       }  
                   b r e a k ;  
             c a s e   2 :     / / X A U U S D  
                   s w i t c h ( P e r i o d ( ) )  
                       {  
                         c a s e   1 5   :  
                               P r i n t ( " L o a d S p e c i a l S y m b o l _ P a r a m e t e r s   L o a d _ X A U U S D _ 1 5 " ) ;  
                               L o a d _ X A U U S D _ 1 5 ( ) ;  
  
                               b r e a k ;  
                         c a s e   6 0   :  
                               b r e a k ;  
                       }  
                   b r e a k ;  
             c a s e   3 :   / /   " A U D U S D "  
                   s w i t c h ( P e r i o d ( ) )  
                       {  
                         c a s e   1 5   :  
                               L o a d _ A U D U S D _ 1 5 ( ) ;  
                               / / L o a d _ O p t i m i z a t i o n _ O p e n O r d e r _ L e v e l 1 ( ) ;  
                               / / L o a d _ O p t i m i z a t i o n _ C l o s e O r d e r _ L e v e l 3 ( ) ;  
                               b r e a k ;  
                         c a s e   6 0   :  
                               b r e a k ;  
                       }  
                   b r e a k ;  
             c a s e   4 :   / / " U S D J P Y "  
                   s w i t c h ( P e r i o d ( ) )  
                       {  
                         c a s e   1 5   :  
                               P r i n t ( " L o a d S p e c i a l S y m b o l _ P a r a m e t e r s   L o a d _ U S D J P Y _ 1 5 " ) ;  
                               / / L o a d _ O p t i m i z a t i o n _ O p e n O r d e r _ L e v e l 1 ( ) ;  
                               / / L o a d _ O p t i m i z a t i o n _ C l o s e O r d e r _ L e v e l 3 ( ) ;  
                               / / L o a d _ O p t i m i z a t i o n _ D e t a i l O r d e r _ L e v e l 4 ( ) ;  
                               L o a d _ U S D J P Y _ 1 5 ( ) ;  
                               b r e a k ;  
                         c a s e   6 0   :  
                               b r e a k ;  
                       }  
                   b r e a k ;  
             c a s e   5 :   / / " U S D C A D "  
                   s w i t c h ( P e r i o d ( ) )  
                       {  
                         c a s e   1 5   :  
                               P r i n t ( " L o a d S p e c i a l S y m b o l _ P a r a m e t e r s   L o a d _ U S D C A D _ 1 5 " ) ;  
                               / / L o a d _ O p t i m i z a t i o n _ O p e n O r d e r _ L e v e l 1 ( ) ;  
                               / / L o a d _ O p t i m i z a t i o n _ C l o s e O r d e r _ L e v e l 3 ( ) ;  
                               / / L o a d _ O p t i m i z a t i o n _ D e t a i l O r d e r _ L e v e l 4 ( ) ;  
                               L o a d _ U S D C A D _ 1 5 ( ) ;  
                               b r e a k ;  
                         c a s e   6 0   :  
                               b r e a k ;  
                       }  
                   b r e a k ;  
               c a s e   6 :   / / X A G U S D  
                   s w i t c h ( P e r i o d ( ) )  
                       {  
                         c a s e   1 5   :  
                               P r i n t ( " L o a d S p e c i a l S y m b o l _ P a r a m e t e r s   L o a d _ X A G U S D _ 1 5 " ) ;  
                               L o a d _ S t a n d a r d ( ) ;  
  
                               b r e a k ;  
                         c a s e   6 0   :  
                               b r e a k ;  
                       }  
                   b r e a k ;  
           }  
  
     }  
 / / + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +  
 