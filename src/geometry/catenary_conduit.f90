module catenary_conduit

    use define_settings, only: setting
    use define_globals
    use define_indexes
    use define_keys
    use define_xsect_tables
    use xsect_tables
    use utility, only: util_CLprint

    implicit none

    !%-----------------------------------------------------------------------------
    !% Description:
    !% catenary conduit geometry
    !%

    private

    !public :: catenary_depth_from_volume
    !public :: catenary_topwidth_from_depth
    !public :: catenary_perimeter_from_depth

    ! public :: catenary_area_from_depth_singular
    
    ! public :: catenary_topwidth_from_depth_singular
    
    ! public :: catenary_perimeter_from_depth_singular
    ! public :: catenary_perimeter_from_hydradius_singular
    ! public :: catenary_hyddepth_from_topwidth
    ! !public :: catenary_hyddepth_from_topwidth_singular
    ! public :: catenary_hydradius_from_depth_singular
    ! public :: catenary_normaldepth_from_sectionfactor_singular



    contains
!%
!%==========================================================================
!% PUBLIC
!%==========================================================================
!%
    ! subroutine catenary_depth_from_volume (elemPGx, Npack, thisCol)
    !     !%-----------------------------------------------------------------------------
    !     !% Description:
    !     !% Only applies on conduits 
    !     !% Input elemPGx is pointer (already assigned) for elemPGalltm, elemPGetm or elemPGac
    !     !% Assumes that volume > 0 is enforced in volume computations.
    !     !% NOTE: this does NOT limit the depth by surcharge height at this point
    !     !% This will be done after the head is computed.
    !     !%-----------------------------------------------------------------------------
    !     integer, target, intent(in) :: elemPGx(:,:), Npack, thisCol
    !     integer, pointer :: thisP(:)
    !     real(8), pointer :: depth(:), volume(:), length(:), AoverAfull(:)
    !     real(8), pointer :: YoverYfull(:), fullArea(:), fulldepth(:)
    !     !%-----------------------------------------------------------------------------
    !     thisP      => elemPGx(1:Npack,thisCol)
    !     depth      => elemR(:,er_Depth)
    !     volume     => elemR(:,er_Volume)
    !     length     => elemR(:,er_Length)
    !     fullArea   => elemR(:,er_FullArea)
    !     fulldepth  => elemR(:,er_FullDepth)
    !     AoverAfull => elemSGR(:,esgr_Catenary_AoverAfull)
    !     YoverYfull => elemSGR(:,esgr_Catenary_YoverYfull)
    !     !%-----------------------------------------------------------------------------
    !     !% --- compute the relative volume
    !     AoverAfull(thisP) = volume(thisP) / (length(thisP) * fullArea(thisP))
      
    !     !% retrive the normalized Y/Yfull from the lookup table
    !     call xsect_table_lookup &
    !         (YoverYfull, AoverAfull, YCatenary, thisP)  

    !     !% finally get the depth by multiplying the normalized depth with full depth
    !     depth(thisP) = YoverYfull(thisP) * fulldepth(thisP)

    ! end subroutine catenary_depth_from_volume
!%
!%==========================================================================   
!%==========================================================================
!%
    ! subroutine catenary_topwidth_from_depth (elemPGx, Npack, thisCol)
    !     !%
    !     !%-----------------------------------------------------------------------------
    !     !% Description:
    !     !% Computes the topwidth from a known depth in a catenary conduit
    !     !%-----------------------------------------------------------------------------
    !     integer, target, intent(in) :: elemPGx(:,:), Npack, thisCol
    !     integer, pointer :: thisP(:)
    !     real(8), pointer :: depth(:), topwidth(:), YoverYfull(:), fulldepth(:)
    !     !%-----------------------------------------------------------------------------
    !     !!if (crashYN) return
    !     thisP      => elemPGx(1:Npack,thisCol)
    !     depth      => elemR(:,er_Depth)
    !     topwidth   => elemR(:,er_Topwidth)
    !     fulldepth  => elemR(:,er_FullDepth)
    !     YoverYfull => elemSGR(:,esgr_Catenary_YoverYfull)
    !     !%-----------------------------------------------------------------------------

    !     !% Calculate normalized depth
    !     YoverYfull(thisP) = depth(thisP) / fulldepth(thisP)

    !     !% retrive the normalized T/Tmax from the lookup table
    !     !% T/Tmax value is temporarily saved in the topwidth column
    !     call xsect_table_lookup &
    !         (topwidth, YoverYfull, TCatenary, thisP) 

    !     !% finally get the topwidth by multiplying the T/Tmax with full depth
    !     topwidth(thisP) = max (topwidth(thisP) * fulldepth(thisP), setting%ZeroValue%Topwidth)

    ! end subroutine catenary_topwidth_from_depth
!%
!%==========================================================================
!%==========================================================================
!%
    ! subroutine catenary_hydraulic_radius_from_area (elemPGx, Npack, thisCol)
    !     !%------------------------------------------------------------------
    !     !% Description:
    !     !% Computes the hydraulic from a known depth in a catenary conduit
    !     !%------------------------------------------------------------------
    !         integer, target, intent(in) :: elemPGx(:,:), Npack, thisCol
    !         integer, pointer :: thisP(:)
    !         real(8), pointer :: depth(:), hydRadius(:), fullperimeter(:) 
    !         real(8), pointer :: fullDepth(:), fullArea(:), perimeter(:), area(:) 
    !         real(8), pointer :: AoverAfull(:), SoverSfull(:), YoverYfull(:), Sfactor(:)
    !     !%------------------------------------------------------------------
    !     !% Preliminaries:
    !         if (Npack < 1) return
    !     !%------------------------------------------------------------------
    !     !% Aliases
    !         thisP      => elemPGx(1:Npack,thisCol)
    !         depth      => elemR(:,er_Depth)
    !         area       => elemR(:,er_Area)
    !         hydRadius  => elemR(:,er_HydRadius)
    !         perimeter  => elemR(:,er_Perimeter)
    !         fullDepth  => elemR(:,er_FullDepth)
    !         fullArea   => elemR(:,er_FullArea)
    !         Sfactor    => elemR(:,er_Temp01)
    !         AoverAfull => elemSGR(:,esgr_Catenary_AoverAfull)
    !         YoverYfull => elemSGR(:,esgr_Catenary_YoverYfull)
    !         SoverSfull => elemSGR(:,esgr_Catenary_SoverSfull)
    !         fullperimeter => elemR(:,er_FullPerimeter)
    !     !%-----------------------------------------------------------------------------

    !     !% calculate normalized depth
    !     !YoverYfull(thisP) = depth(thisP) / fulldepth(thisP)

    !     !% AREA ALREADY COMPUTED
    !     ! !% setp 1: A/Afull from Y/Yfull
    !     ! call xsect_table_lookup &
    !     !     (AoverAfull, YoverYfull, ACatenary, thisP)

    !     ! area(thisP) = AoverAfull(thisP) * fullArea(thisP)

    !     !% Section factor find S/Sfull from A/Afull
    !     call xsect_table_lookup &
    !         (SoverSfull, AoverAfull, SCatenary, thisP)

    !     !% find the section factor 
    !     !% sF_full = Afull * (rFull) ^ (2/3)
    !     !% rFull   = 0.23172 * yFull
    !     !% sF = sF_full * sF/sF_full
    !     Sfactor(thisP) = (fullArea(thisP) * (0.23172 * fullDepth(thisP)) ** twoThirdR) &
    !                    * SoverSfull(thisP)

    !     !% retrieve hyrdaulic radius from section factor
    !     hydRadius(thisP) = (Sfactor(thisP) / area(thisP)) ** threehalfR

    ! end subroutine catenary_hydraulic_radius_from_area    
!%
!%==========================================================================
!%==========================================================================
!%
!     subroutine catenary_perimeter_from_depth (elemPGx, Npack, thisCol)
!         !%
!         !%-----------------------------------------------------------------------------
!         !% Description:
!         !% Computes the perimeter from a known depth in a catenary conduit
!         !%-----------------------------------------------------------------------------
!         integer, target, intent(in) :: elemPGx(:,:), Npack, thisCol
!         integer, pointer :: thisP(:)
!         real(8), pointer :: depth(:), hydRadius(:), fullperimeter(:) 
!         real(8), pointer :: fullDepth(:), fullArea(:), perimeter(:), area(:) 
!         real(8), pointer :: AoverAfull(:), SoverSfull(:), YoverYfull(:), Sfactor(:)
!         !%-----------------------------------------------------------------------------
!         !!if (crashYN) return
!         thisP      => elemPGx(1:Npack,thisCol)
!         depth      => elemR(:,er_Depth)
!         area       => elemR(:,er_Area)
!         hydRadius  => elemR(:,er_HydRadius)
!         perimeter  => elemR(:,er_Perimeter)
!         fullDepth  => elemR(:,er_FullDepth)
!         fullArea   => elemR(:,er_FullArea)
!         Sfactor    => elemR(:,er_Temp01)
!         AoverAfull => elemSGR(:,esgr_Catenary_AoverAfull)
!         YoverYfull => elemSGR(:,esgr_Catenary_YoverYfull)
!         SoverSfull => elemSGR(:,esgr_Catenary_SoverSfull)
!         fullperimeter => elemR(:,er_FullPerimeter)
!         !%-----------------------------------------------------------------------------

!         !% calculate normalized depth
!         YoverYfull(thisP) = depth(thisP) / fulldepth(thisP)

!         !% setp 1: A/Afull from Y/Yfull
!         call xsect_table_lookup &
!             (AoverAfull, YoverYfull, ACatenary, thisP)

!         area(thisP) = AoverAfull(thisP) * fullArea(thisP)

!         !% step 2: find S/Sfull from A/Afull
!         call xsect_table_lookup &
!             (SoverSfull, AoverAfull, SCatenary, thisP)

!         !% find the section factor 
!         !% sF_full = Afull * (rFull) ^ (2/3)
!         !% rFull   = 0.23172 * yFull
!         !% sF = sF_full * sF/sF_full
!         Sfactor(thisP) = (fullArea(thisP) * (0.23172 * fullDepth(thisP)) ** twoThirdR) &
!                        * SoverSfull(thisP)

!         !% retrive hyrdaulic radius from section factor
!         hydRadius(thisP) = (Sfactor(thisP) / area(thisP)) ** threehalfR

!         !% finally get the perimeter by dividing area by hydRadius
!         perimeter(thisP) = min (area(thisP) / hydRadius(thisP), fullperimeter(thisP))

!         !% HACK: perimeter correction is needed when the pipe is empty.
!     end subroutine catenary_perimeter_from_depth
! !%
! !%==========================================================================
! !%==========================================================================
! !%
!     subroutine catenary_hyddepth_from_topwidth (elemPGx, Npack, thisCol)
!         !%
!         !%-----------------------------------------------------------------------------
!         !% Description:
!         !% Computes the hydraulic (average) depth from a known depth in a catenary conduit
!         !%-----------------------------------------------------------------------------
!         integer, target, intent(in) :: elemPGx(:,:)
!         integer, intent(in) ::  Npack, thisCol
!         integer, pointer    :: thisP(:)
!         real(8), pointer    :: area(:), topwidth(:), fullHydDepth(:)
!         real(8), pointer    :: depth(:), hyddepth(:)
!         !%-----------------------------------------------------------------------------
!         !!if (crashYN) return
!         thisP        => elemPGx(1:Npack,thisCol)
!         area         => elemR(:,er_Area)
!         topwidth     => elemR(:,er_Topwidth)
!         depth        => elemR(:,er_Depth)
!         hyddepth     => elemR(:,er_HydDepth)
!         fullHydDepth => elemR(:,er_FullHydDepth)
!         !%--------------------------------------------------

!         !% calculating hydraulic depth needs conditional since,
!         !% topwidth can be zero in catenary cross section for both
!         !% full and empty condition.

!         !% when conduit is empty
!         where (depth(thisP) <= setting%ZeroValue%Depth)
!             hyddepth(thisP) = setting%ZeroValue%Depth

!         !% when conduit is not empty
!         elsewhere (depth(thisP) > setting%ZeroValue%Depth)
!             !% limiter for when the conduit is full
!             hyddepth(thisP) = min(area(thisP) / topwidth(thisP), fullHydDepth(thisP))
!         endwhere

!     end subroutine catenary_hyddepth_from_topwidth
! !%
! !%==========================================================================
! !% SINGULAR
! !%==========================================================================
! !%
!     real(8) function catenary_area_from_depth_singular (indx, depth) result (outvalue)
!         !%-----------------------------------------------------------------------------
!         !% Description:
!         !% Computes area from known depth for catenary cross section of a single element
!         !% The input indx is the row index in full data 2D array.
!         !%-----------------------------------------------------------------------------
!         integer, intent(in) :: indx
!         real(8), intent(in) :: depth
!         real(8), pointer    :: AoverAfull(:), YoverYfull(:)
!         real(8), pointer    :: fullArea(:), fulldepth(:)
!         !%-----------------------------------------------------------------------------
!         !!if (crashYN) return
!         fullArea   => elemR(:,er_FullArea)
!         fulldepth  => elemR(:,er_FullDepth)
!         AoverAfull => elemSGR(:,esgr_Catenary_AoverAfull)
!         YoverYfull => elemSGR(:,esgr_Catenary_YoverYfull)
!         !%-----------------------------------------------------------------------------

!         !% find Y/Yfull
!         YoverYfull(indx) = depth / fulldepth(indx)

!         !% get A/Afull from the lookup table using Y/Yfull
!         AoverAfull(indx) = xsect_table_lookup_singular (YoverYfull(indx), ACatenary)

!         !% finally get the area by multiplying the normalized area with full area
!         outvalue = AoverAfull(indx) * fullArea(indx)

!     end function catenary_area_from_depth_singular
! !%
! !%==========================================================================
! !%==========================================================================
! !%
!     real(8) function catenary_topwidth_from_depth_singular (indx,depth) result (outvalue)
!         !%-----------------------------------------------------------------------------
!         !% Description:
!         !% Computes the topwidth for a catenary cross section of a single element
!         !%-----------------------------------------------------------------------------
!         integer, intent(in) :: indx
!         real(8), intent(in) :: depth
!         real(8), pointer    ::  YoverYfull(:), fulldepth(:)
!         !%-----------------------------------------------------------------------------
!         fulldepth  => elemR(:,er_FullDepth)
!         YoverYfull => elemSGR(:,esgr_Catenary_YoverYfull)
!         !%-----------------------------------------------------------------------------

!         !% find Y/Yfull
!         YoverYfull(indx) = depth / fulldepth(indx)

!         !% get topwidth by first retriving T/Tmax from the lookup table using Y/Yfull
!         !% and then myltiplying it with Tmax (fullDepth for catenary cross-section)
!         outvalue = fulldepth(indx) * xsect_table_lookup_singular (YoverYfull(indx), TCatenary) 

!         !% if topwidth <= zero, set it to zerovalue
!         outvalue = max(outvalue, setting%ZeroValue%Topwidth)

!     end function catenary_topwidth_from_depth_singular
! !%
! !%==========================================================================
! !%==========================================================================
! !%
!     real(8) function catenary_hydradius_from_depth_singular (indx,depth) result (outvalue)
!         !%
!         !%-----------------------------------------------------------------------------
!         !% Description:
!         !% Computes hydraulic radius from known depth for a catenary cross section of
!         !% a single element
!         !%-----------------------------------------------------------------------------
!         integer, intent(in) :: indx
!         real(8), intent(in) :: depth
!         real(8), pointer    :: YoverYfull(:), fulldepth(:), fullarea(:)
!         real(8) :: area, sF
!         !%-----------------------------------------------------------------------------
!         fulldepth  => elemR(:,er_FullDepth)
!         fullarea   => elemR(:,er_FullArea)
!         YoverYfull => elemSGR(:,esgr_Catenary_YoverYfull)
!         !%-----------------------------------------------------------------------------
!         !% find Y/Yfull
!         YoverYfull(indx) = depth / fulldepth(indx)

!         !%  find the normalized area
!         area =  xsect_table_lookup_singular (YoverYfull(indx), ACatenary)
!         !%  find normalized sectionfactor for this depth from lookup table
!         sf = xsect_table_lookup_singular (area, SCatenary)
!         !%  unnormalize
!         sF = (fullarea(indx) * (0.23172 * fullDepth(indx)) ** twoThirdR) * sF
!         area = area * fullarea(indx)

!         !% retrive hyrdaulic radius from section factor
!         outvalue = (sF / area) ** threehalfR

!     end function catenary_hydradius_from_depth_singular
! !%
! !%==========================================================================
! !%==========================================================================
! !%
!     real(8) function catenary_perimeter_from_hydradius_singular (indx,hydradius) result (outvalue)
!         !%
!         !%-----------------------------------------------------------------------------
!         !% Description:
!         !% Computes wetted perimeter from known depth for a catenary cross section of
!         !% a single element
!         !%-----------------------------------------------------------------------------
!         !%-----------------------------------------------------------------------------
!         integer, intent(in) :: indx
!         real(8), intent(in) :: hydradius
!         real(8), pointer ::  area(:), fullperimeter(:)
!         !%-----------------------------------------------------------------------------
!         area          => elemR(:,er_Area)
!         fullperimeter => elemR(:,er_FullPerimeter)
!         !%-----------------------------------------------------------------------------

!         outvalue = min(area(indx) / hydRadius, fullperimeter(indx))

!         !% HACK: perimeter correction is needed when the pipe is empty

!     end function catenary_perimeter_from_hydradius_singular
! !%
! !%==========================================================================    
! !%==========================================================================
! !%
!     real(8) function catenary_perimeter_from_depth_singular &
!         (idx, indepth) result(outvalue)
!         !%------------------------------------------------------------------
!         !% Description:
!         !% Computes the catenary conduit perimeter for the given depth on
!         !% the element idx
!         !%------------------------------------------------------------------
!         !% Declarations:
!             integer, intent(in) :: idx
!             real(8), intent(in) :: indepth
!             real(8), pointer :: fulldepth, fullarea, fullperimeter
!             real(8) :: hydRadius, YoverYfull, AoverAfull, area, sf

!         !%------------------------------------------------------------------
!         !% Aliases
!             fulldepth     => elemR(idx,er_FullDepth)
!             fullarea      => elemR(idx,er_FullArea)
!             fullperimeter => elemR(idx,er_FullPerimeter)
!         !%------------------------------------------------------------------
!         YoverYfull = indepth / fulldepth

!         !% --- retrieve normalized area for this depth from lookup table
!         AoverAfull = xsect_table_lookup_singular (YoverYfull, ACatenary)

!         !% --- retrieve normalized sectionfactor for this depth from lookup table
!         sf = xsect_table_lookup_singular (AoverAfull, SCatenary)

!         !% --- unnormalize
!         sF = (fullArea * (0.23172 * fullDepth) ** twoThirdR) * sf
!         area = AoverAfull * fullarea
!         !% retrive hyrdaulic radius from section factor
!         hydRadius = (sF / area) ** threehalfR

!         !% --- get the perimeter by dividing area by hydRadius
!         outvalue = min(area / hydRadius, fullperimeter)

!     end function catenary_perimeter_from_depth_singular
! !%
! !%==========================================================================
! !%==========================================================================
! !%
!     ! real(8) function catenary_hyddepth_from_depth_singular (indx,depth) result (outvalue)
!     !     !%
!     !     !%-----------------------------------------------------------------------------
!     !     !% Description:
!     !     !% Computes hydraulic depth from known depth for catenary cross section of
!     !     !% a single element
!     !     !%-----------------------------------------------------------------------------
!     !         integer, intent(in) :: indx
!     !         real(8), intent(in) :: depth
!     !         real(8), pointer    :: fullDepth, fullHydDepth
!     !     !%-----------------------------------------------------------------------------
!     !         fullDepth    => elemR(indx,er_FullDepth)
!     !         fullHydDepth => elemR(indx,er_FullHydDepth)
!     !     !%--------------------------------------------------

!     !     topwidth = catenary_topwidth_from_depth_singular (indx,depth)
!     !     area     = catenary_area_from_depth_singular (indx, depth)

!     !     if (depth <= setting%ZeroValue%Depth) then
!     !         !% --- empty
!     !         outvalue = setting%ZeroValue%Depth
!     !     elseif (depth >= fullHydDepth)
!     !         !% --- full
!     !         outvalue = fullHydDepth
!     !     else
!     !         !% --- otherwise
!     !         outvalue = area / topwidth
!     !     endif

!     ! end function catenary_hyddepth_from_depth_singular
! !%
! !%==========================================================================
! !%==========================================================================
! !%
!     real(8) function catenary_normaldepth_from_sectionfactor_singular &
!          (SFidx, inSF) result (outvalue)
!         !%------------------------------------------------------------------
!         !% Description
!         !% Computes the depth using the input section factor. This result is
!         !% the normal depth of the flow. Note that the element MUST be in 
!         !% the set of elements with tables stored in the uniformTableDataR
!         !%------------------------------------------------------------------
!         !% Declarations
!             integer, intent(in) :: SFidx ! index in the section factor table
!             real(8), intent(in) :: inSF
!             integer, pointer    :: eIdx  !% element index
!             real(8), pointer    :: thisTable(:)
!             real(8)             :: normInput
!         !%------------------------------------------------------------------
!             thisTable => uniformTableDataR(SFidx,:,utd_SF_depth_nonuniform)
!             eIdx      => uniformTableI(SFidx,uti_elem_idx)
!         !%------------------------------------------------------------------
!         !% --- normalize the input
!         normInput = inSF / uniformTableR(SFidx,utr_SFmax)
!         !% --- lookup the normalized depth
!         outvalue = (xsect_table_lookup_singular(normInput,thisTable))
!         !% --- unnormalize the depth for the output
!         outvalue = outvalue * elemR(eIdx,er_FullDepth)

!     end function catenary_normaldepth_from_sectionfactor_singular
!%
!%==========================================================================
!% END OF MODULE
!%+=========================================================================
end module catenary_conduit