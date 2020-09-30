/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

#include "xsi.h"

struct XSI_INFO xsi_info;



int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    work_m_00860693398126411336_3867645508_init();
    work_m_17462607965056830779_1230060795_init();
    work_m_07719128559112227087_1667949733_init();
    work_m_15836805808804626931_0286164271_init();
    work_m_04336682477805643771_2578365841_init();
    work_m_16541823861846354283_2073120511_init();


    xsi_register_tops("work_m_04336682477805643771_2578365841");
    xsi_register_tops("work_m_16541823861846354283_2073120511");


    return xsi_run_simulation(argc, argv);

}
