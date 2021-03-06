#include <insider_itc.h>

#include "constant.h"
#include "structure.h"

#include "app_intg_mat_rdc.cpp"
#include "app_intg_matcher.cpp"
#include "app_intg_rdc_16to8.cpp"
#include "app_intg_rdc_32to16.cpp"
#include "app_intg_rdc_4to2.cpp"
#include "app_intg_rdc_8to4.cpp"
#include "app_intg_verifier.cpp"
#include "app_intg_writer.cpp"

#include "insider_itc.h"

#include "command_handler.cpp"
#include "device_delayed_channel_forwarder.cpp"
#include "device_dram_delay_unit.cpp"
#include "device_dram_req_time_marker.cpp"
#include "device_dram_throttle_unit.cpp"
#include "device_pipe0_dram_dispatcher.cpp"
#include "device_pipe1_dram_dispatcher.cpp"
#include "dramA_read_req_multiplexer.cpp"
#include "dramA_read_resp_multiplexer.cpp"
#include "dramA_write_multiplexer.cpp"
#include "dramB_read_req_multiplexer.cpp"
#include "dramB_read_resp_multiplexer.cpp"
#include "dramB_write_multiplexer.cpp"
#include "dramC_read_req_multiplexer.cpp"
#include "dramC_read_resp_multiplexer.cpp"
#include "dramC_write_multiplexer.cpp"
#include "dramD_read_req_multiplexer.cpp"
#include "dramD_read_resp_multiplexer.cpp"
#include "dramD_write_multiplexer.cpp"
#include "dram_helper_app.cpp"
#include "host_delayed_channel_forwarder.cpp"
#include "host_dram_delay_unit.cpp"
#include "host_dram_req_time_marker.cpp"
#include "host_dram_throttle_unit.cpp"
#include "host_pipe0_dram_dispatcher.cpp"
#include "host_pipe1_dram_dispatcher.cpp"
#include "keeper_pcie_read_resp.cpp"
#include "pcie_data_splitter_app.cpp"
#include "pcie_helper_app.cpp"
#include "pcie_read_context_forwarder.cpp"
#include "pcie_read_req_mux.cpp"
#include "pcie_read_resp_mux.cpp"
#include "pcie_write_multiplexer.cpp"
#include "pipe0_data_handler.cpp"
#include "pipe1_data_handler.cpp"
#include "pipe2_data_handler.cpp"
#include "pipeline_data_passer.cpp"
#include "reset_propaganda.cpp"
#include "unused_channel_preserver.cpp"

#define COSIM_DRAMA_ADDR_OFFSET (4LL << 32)
#define COSIM_DRAMB_ADDR_OFFSET (8LL << 32)
#define COSIM_DRAMC_ADDR_OFFSET (12LL << 32)
#define COSIM_DRAMD_ADDR_OFFSET (16LL << 32)

void interconnects() {
  ST_Queue<unsigned char> pcie_read_multiplexer_write_context(128);
  ST_Queue<unsigned char> pcie_read_multiplexer_read_context(128);

  ST_Queue<PCIe_Read_Req> hw_pcie_read_req(128);
  ST_Queue<PCIe_Read_Resp> hw_pcie_read_resp(128);

  ST_Queue<Dram_Read_Req> cosim_dramA_read_req(128);
  ST_Queue<Dram_Read_Resp> cosim_dramA_read_resp(128);
  ST_Queue<Dram_Write_Req_Data> cosim_dramA_write_req_data(128);
  ST_Queue<Dram_Write_Req_Apply> cosim_dramA_write_req_apply(128);

  ST_Queue<Dram_Read_Req> cosim_dramB_read_req(128);
  ST_Queue<Dram_Read_Resp> cosim_dramB_read_resp(128);
  ST_Queue<Dram_Write_Req_Data> cosim_dramB_write_req_data(128);
  ST_Queue<Dram_Write_Req_Apply> cosim_dramB_write_req_apply(128);

  ST_Queue<Dram_Read_Req> cosim_dramC_read_req(128);
  ST_Queue<Dram_Read_Resp> cosim_dramC_read_resp(128);
  ST_Queue<Dram_Write_Req_Data> cosim_dramC_write_req_data(128);
  ST_Queue<Dram_Write_Req_Apply> cosim_dramC_write_req_apply(128);

  ST_Queue<Dram_Read_Req> cosim_dramD_read_req(128);
  ST_Queue<Dram_Read_Resp> cosim_dramD_read_resp(128);
  ST_Queue<Dram_Write_Req_Data> cosim_dramD_write_req_data(128);
  ST_Queue<Dram_Write_Req_Apply> cosim_dramD_write_req_apply(128);

  ST_Queue<PCIe_Read_Resp> buffered_pcie_read_resp(4096);
  ST_Queue<Request> reqs_incoming(128);
  ST_Queue<Request> reqs_pipe0_write(128);
  ST_Queue<Request> reqs_pipe1_read(128);
  ST_Queue<Request> reqs_pipe1_write(128);
  ST_Queue<Request> reqs_pipe2_read(128);
  ST_Queue<Data> data_pipe1_write(128);
  ST_Queue<Data> data_pipe2_read(128);
  ST_Queue<bool> data_valid_pipe1_write(128);
  ST_Queue<bool> data_valid_pipe2_read(128);
  ST_Queue<unsigned long long> kbuf_addr_pipe0_write(128);
  ST_Queue<unsigned long long> kbuf_addr_pipe2_read(128);

  ST_Queue<unsigned int> kbuf_addrs(16);
  ST_Queue<PCIe_Write_Req_Data> host_data_pcie_write_req_data(128);
  ST_Queue<PCIe_Write_Req_Apply> host_data_pcie_write_req_apply(128);
  ST_Queue<PCIe_Write_Req_Data> host_fin_pcie_write_req_data(128);
  ST_Queue<PCIe_Write_Req_Apply> host_fin_pcie_write_req_apply(128);

  ST_Queue<Dram_Read_Req> host_dram_read_req(128);
  ST_Queue<Dram_Read_Resp> host_dram_read_resp(128);
  ST_Queue<Dram_Write_Req_Data> host_dram_write_req_data(128);
  ST_Queue<Dram_Write_Req_Apply> host_dram_write_req_apply(128);

  ST_Queue<Dram_Read_Req_With_Time> host_dram_read_req_with_time(128);
  ST_Queue<Dram_Write_Req_Apply_With_Time> host_dram_write_req_apply_with_time(
      128);
  ST_Queue<unsigned int> host_delay_cycle_cnts(4);

  ST_Queue<Dram_Read_Req> host_dram_read_req_delayed(128);
  ST_Queue<Dram_Read_Resp> host_dram_read_resp_delayed(128);
  ST_Queue<Dram_Write_Req_Apply> host_dram_write_req_apply_delayed(128);
  ST_Queue<Dram_Write_Req_Data> host_dram_write_req_data_delayed(128);

  ST_Queue<Dram_Read_Resp> host_dram_read_resp_throttled(128);
  ST_Queue<Dram_Write_Req_Data> host_dram_write_req_data_throttled(128);
  ST_Queue<bool> host_dram_write_resp(128);
  ST_Queue<unsigned int> host_throttle_params(4);

  ST_Queue<Dram_Dispatcher_Write_Req> host_dram_dispatcher_write_context(128);
  ST_Queue<Dram_Dispatcher_Read_Req> host_dram_dispatcher_read_context(128);

  ST_Queue<Dram_Read_Req> host_dramA_read_req(128);
  ST_Queue<Dram_Read_Resp> host_dramA_read_resp(128);
  ST_Queue<Dram_Write_Req_Data> host_dramA_write_req_data(128);
  ST_Queue<Dram_Write_Req_Apply> host_dramA_write_req_apply(128);

  ST_Queue<Dram_Read_Req> host_dramB_read_req(128);
  ST_Queue<Dram_Read_Resp> host_dramB_read_resp(128);
  ST_Queue<Dram_Write_Req_Data> host_dramB_write_req_data(128);
  ST_Queue<Dram_Write_Req_Apply> host_dramB_write_req_apply(128);

  ST_Queue<Dram_Read_Req> host_dramC_read_req(128);
  ST_Queue<Dram_Read_Resp> host_dramC_read_resp(128);
  ST_Queue<Dram_Write_Req_Data> host_dramC_write_req_data(128);
  ST_Queue<Dram_Write_Req_Apply> host_dramC_write_req_apply(128);

  ST_Queue<Dram_Read_Req> host_dramD_read_req(128);
  ST_Queue<Dram_Read_Resp> host_dramD_read_resp(128);
  ST_Queue<Dram_Write_Req_Data> host_dramD_write_req_data(128);
  ST_Queue<Dram_Write_Req_Apply> host_dramD_write_req_apply(128);

  ST_Queue<Dram_Read_Req> device_dram_read_req(128);
  ST_Queue<Dram_Read_Resp> device_dram_read_resp(128);
  ST_Queue<Dram_Write_Req_Data> device_dram_write_req_data(128);
  ST_Queue<Dram_Write_Req_Apply> device_dram_write_req_apply(128);

  ST_Queue<Dram_Read_Req_With_Time> device_dram_read_req_with_time(128);
  ST_Queue<Dram_Write_Req_Apply_With_Time>
      device_dram_write_req_apply_with_time(128);
  ST_Queue<unsigned int> device_delay_cycle_cnts(4);

  ST_Queue<Dram_Read_Req> device_dram_read_req_delayed(128);
  ST_Queue<Dram_Read_Resp> device_dram_read_resp_delayed(128);
  ST_Queue<Dram_Write_Req_Apply> device_dram_write_req_apply_delayed(128);
  ST_Queue<Dram_Write_Req_Data> device_dram_write_req_data_delayed(128);

  ST_Queue<Dram_Read_Resp> device_dram_read_resp_throttled(128);
  ST_Queue<Dram_Write_Req_Data> device_dram_write_req_data_throttled(128);
  ST_Queue<unsigned int> device_throttle_params(4);

  ST_Queue<Dram_Dispatcher_Write_Req> device_dram_dispatcher_write_context(128);
  ST_Queue<Dram_Dispatcher_Read_Req> device_dram_dispatcher_read_context(128);

  ST_Queue<Dram_Read_Req> device_dramA_read_req(128);
  ST_Queue<Dram_Read_Resp> device_dramA_read_resp(128);
  ST_Queue<Dram_Write_Req_Data> device_dramA_write_req_data(128);
  ST_Queue<Dram_Write_Req_Apply> device_dramA_write_req_apply(128);

  ST_Queue<Dram_Read_Req> device_dramB_read_req(128);
  ST_Queue<Dram_Read_Resp> device_dramB_read_resp(128);
  ST_Queue<Dram_Write_Req_Data> device_dramB_write_req_data(128);
  ST_Queue<Dram_Write_Req_Apply> device_dramB_write_req_apply(128);

  ST_Queue<Dram_Read_Req> device_dramC_read_req(128);
  ST_Queue<Dram_Read_Resp> device_dramC_read_resp(128);
  ST_Queue<Dram_Write_Req_Data> device_dramC_write_req_data(128);
  ST_Queue<Dram_Write_Req_Apply> device_dramC_write_req_apply(128);

  ST_Queue<Dram_Read_Req> device_dramD_read_req(128);
  ST_Queue<Dram_Read_Resp> device_dramD_read_resp(128);
  ST_Queue<Dram_Write_Req_Data> device_dramD_write_req_data(128);
  ST_Queue<Dram_Write_Req_Apply> device_dramD_write_req_apply(128);

  ST_Queue<PCIe_Write_Req_Data> device_pcie_write_req_data(128);
  ST_Queue<PCIe_Write_Req_Apply> device_pcie_write_req_apply(128);

  ST_Queue<bool> dramA_read_context(128);
  ST_Queue<bool> dramB_read_context(128);
  ST_Queue<bool> dramC_read_context(128);
  ST_Queue<bool> dramD_read_context(128);

  ST_Queue<bool> app_free_buf(4);
  ST_Queue<unsigned int> app_file_infos(4);
  ST_Queue<unsigned int> app_buf_addrs(4);
  ST_Queue<unsigned int> app_input_params(4);
  ST_Queue<APP_Data> app_input_data(128);
  ST_Queue<APP_Data> app_output_data(128);
  ST_Queue<APP_Data> app_output_data_splitted(128);
  ST_Queue<APP_Data_Meta> app_output_data_meta(128);

  ST_Queue<bool> preserver_cheat_signals(4);

  ST_Queue<bool> reset_sigs(4);
  ST_Queue<bool> reset_dram_helper_app(4);
  ST_Queue<bool> reset_pcie_helper_app(4);
  ST_Queue<bool> reset_pcie_data_splitter_app(4);

  keeper_pcie_read_resp(pcie_read_resp, buffered_pcie_read_resp);
  pipe0_data_handler(kbuf_addrs, reqs_incoming, host_dram_read_req,
                     hw_pcie_read_req, reqs_pipe0_write, kbuf_addr_pipe0_write);
  pipe1_data_handler(reqs_pipe1_read, host_dram_read_resp, hw_pcie_read_resp,
                     reqs_pipe1_write, data_valid_pipe1_write,
                     data_pipe1_write);
  pipe2_data_handler(
      reqs_pipe2_read, data_valid_pipe2_read, kbuf_addr_pipe2_read,
      data_pipe2_read, host_data_pcie_write_req_apply,
      host_fin_pcie_write_req_apply, host_data_pcie_write_req_data,
      host_dram_write_req_apply, host_dram_write_req_data,
      host_fin_pcie_write_req_data, host_dram_write_resp);
  command_handler(poke, reqs_incoming, kbuf_addrs, host_delay_cycle_cnts,
                  host_throttle_params, device_delay_cycle_cnts,
                  device_throttle_params, preserver_cheat_signals,
                  app_file_infos, app_buf_addrs, app_free_buf, app_input_params,
                  reset_sigs);
  pcie_write_multiplexer(
      host_data_pcie_write_req_data, host_data_pcie_write_req_apply,
      pcie_write_req_data, pcie_write_req_apply, host_fin_pcie_write_req_data,
      host_fin_pcie_write_req_apply, device_pcie_write_req_data,
      device_pcie_write_req_apply, cosim_dramA_write_req_data,
      cosim_dramA_write_req_apply, cosim_dramB_write_req_data,
      cosim_dramB_write_req_apply, cosim_dramC_write_req_data,
      cosim_dramC_write_req_apply, cosim_dramD_write_req_data,
      cosim_dramD_write_req_apply);
  pcie_read_req_mux(pcie_read_req, hw_pcie_read_req, cosim_dramA_read_req,
                    cosim_dramB_read_req, cosim_dramC_read_req,
                    cosim_dramD_read_req, pcie_read_multiplexer_write_context);
  pcie_read_resp_mux(buffered_pcie_read_resp, hw_pcie_read_resp,
                     cosim_dramA_read_resp, cosim_dramB_read_resp,
                     cosim_dramC_read_resp, cosim_dramD_read_resp,
                     pcie_read_multiplexer_read_context);
  pcie_read_context_forwarder(pcie_read_multiplexer_write_context,
                              pcie_read_multiplexer_read_context);
  pipeline_data_passer(reqs_pipe0_write, reqs_pipe1_read, reqs_pipe1_write,
                       reqs_pipe2_read, data_pipe1_write, data_pipe2_read,
                       data_valid_pipe1_write, data_valid_pipe2_read,
                       kbuf_addr_pipe0_write, kbuf_addr_pipe2_read);

  host_dram_req_time_marker(host_dram_read_req, host_dram_write_req_apply,
                            host_dram_read_req_with_time,
                            host_dram_write_req_apply_with_time);
  host_dram_delay_unit(host_delay_cycle_cnts, host_dram_read_req_with_time,
                       host_dram_write_req_apply_with_time,
                       host_dram_read_req_delayed,
                       host_dram_write_req_apply_delayed);
  host_delayed_channel_forwarder(
      host_dram_write_req_data, host_dram_write_req_data_delayed,
      host_dram_read_resp_delayed, host_dram_read_resp);
  host_dram_throttle_unit(host_dram_write_req_data_throttled,
                          host_dram_write_req_data_delayed,
                          host_dram_read_resp_throttled,
                          host_dram_read_resp_delayed, host_throttle_params);
  host_pipe0_dram_dispatcher(
      host_dram_read_req_delayed, host_dram_write_req_apply_delayed,
      host_dramA_read_req, host_dramA_write_req_apply, host_dramB_read_req,
      host_dramB_write_req_apply, host_dramC_read_req,
      host_dramC_write_req_apply, host_dramD_read_req,
      host_dramD_write_req_apply, host_dram_dispatcher_write_context,
      host_dram_dispatcher_read_context, host_dram_write_resp);
  host_pipe1_dram_dispatcher(
      host_dram_read_resp_throttled, host_dram_write_req_data_throttled,
      host_dramA_read_resp, host_dramA_write_req_data, host_dramB_read_resp,
      host_dramB_write_req_data, host_dramC_read_resp,
      host_dramC_write_req_data, host_dramD_read_resp,
      host_dramD_write_req_data, host_dram_dispatcher_write_context,
      host_dram_dispatcher_read_context);

  device_dram_req_time_marker(device_dram_read_req, device_dram_write_req_apply,
                              device_dram_read_req_with_time,
                              device_dram_write_req_apply_with_time);
  device_dram_delay_unit(
      device_delay_cycle_cnts, device_dram_read_req_with_time,
      device_dram_write_req_apply_with_time, device_dram_read_req_delayed,
      device_dram_write_req_apply_delayed);
  device_delayed_channel_forwarder(
      device_dram_write_req_data, device_dram_write_req_data_delayed,
      device_dram_read_resp_delayed, device_dram_read_resp);
  device_dram_throttle_unit(
      device_dram_write_req_data_throttled, device_dram_write_req_data_delayed,
      device_dram_read_resp_throttled, device_dram_read_resp_delayed,
      device_throttle_params);
  device_pipe0_dram_dispatcher(
      device_dram_read_req_delayed, device_dram_write_req_apply_delayed,
      device_dramA_read_req, device_dramA_write_req_apply,
      device_dramB_read_req, device_dramB_write_req_apply,
      device_dramC_read_req, device_dramC_write_req_apply,
      device_dramD_read_req, device_dramD_write_req_apply,
      device_dram_dispatcher_write_context,
      device_dram_dispatcher_read_context);
  device_pipe1_dram_dispatcher(
      device_dram_read_resp_throttled, device_dram_write_req_data_throttled,
      device_dramA_read_resp, device_dramA_write_req_data,
      device_dramB_read_resp, device_dramB_write_req_data,
      device_dramC_read_resp, device_dramC_write_req_data,
      device_dramD_read_resp, device_dramD_write_req_data,
      device_dram_dispatcher_write_context,
      device_dram_dispatcher_read_context);

  dramA_write_multiplexer(
      cosim_dramA_write_req_data, cosim_dramA_write_req_apply,
      host_dramA_write_req_data, host_dramA_write_req_apply,
      device_dramA_write_req_data, device_dramA_write_req_apply);
  dramB_write_multiplexer(
      cosim_dramB_write_req_data, cosim_dramB_write_req_apply,
      host_dramB_write_req_data, host_dramB_write_req_apply,
      device_dramB_write_req_data, device_dramB_write_req_apply);
  dramC_write_multiplexer(
      cosim_dramC_write_req_data, cosim_dramC_write_req_apply,
      host_dramC_write_req_data, host_dramC_write_req_apply,
      device_dramC_write_req_data, device_dramC_write_req_apply);
  dramD_write_multiplexer(
      cosim_dramD_write_req_data, cosim_dramD_write_req_apply,
      host_dramD_write_req_data, host_dramD_write_req_apply,
      device_dramD_write_req_data, device_dramD_write_req_apply);
  dramA_read_req_multiplexer(cosim_dramA_read_req, host_dramA_read_req,
                             device_dramA_read_req, dramA_read_context);
  dramB_read_req_multiplexer(cosim_dramB_read_req, host_dramB_read_req,
                             device_dramB_read_req, dramB_read_context);
  dramC_read_req_multiplexer(cosim_dramC_read_req, host_dramC_read_req,
                             device_dramC_read_req, dramC_read_context);
  dramD_read_req_multiplexer(cosim_dramD_read_req, host_dramD_read_req,
                             device_dramD_read_req, dramD_read_context);
  dramA_read_resp_multiplexer(cosim_dramA_read_resp, host_dramA_read_resp,
                              device_dramA_read_resp, dramA_read_context);
  dramB_read_resp_multiplexer(cosim_dramB_read_resp, host_dramB_read_resp,
                              device_dramB_read_resp, dramB_read_context);
  dramC_read_resp_multiplexer(cosim_dramC_read_resp, host_dramC_read_resp,
                              device_dramC_read_resp, dramC_read_context);
  dramD_read_resp_multiplexer(cosim_dramD_read_resp, host_dramD_read_resp,
                              device_dramD_read_resp, dramD_read_context);

  dram_helper_app(app_file_infos, device_dram_read_req, device_dram_read_resp,
                  app_input_data, reset_dram_helper_app);
  pcie_helper_app(app_buf_addrs, device_pcie_write_req_apply,
                  device_pcie_write_req_data, app_output_data_splitted,
                  app_output_data_meta, app_free_buf, reset_pcie_helper_app);
  pcie_data_splitter_app(app_output_data, app_output_data_splitted,
                         app_output_data_meta, reset_pcie_data_splitter_app);

  unused_channel_preserver(device_dram_write_req_data,
                           device_dram_write_req_apply,
                           preserver_cheat_signals);

  ST_Queue<bool> reset_app_intg_matcher(4);
  ST_Queue<bool> reset_app_intg_mat_rdc(4);
  ST_Queue<bool> reset_app_intg_rdc_16to8(4);
  ST_Queue<bool> reset_app_intg_rdc_32to16(4);
  ST_Queue<bool> reset_app_intg_rdc_4to2(4);
  ST_Queue<bool> reset_app_intg_rdc_8to4(4);
  ST_Queue<bool> reset_app_intg_verifier(4);
  ST_Queue<bool> reset_app_intg_writer(4);
  reset_propaganda(reset_app_intg_matcher, reset_app_intg_mat_rdc,
                   reset_app_intg_rdc_16to8, reset_app_intg_rdc_32to16,
                   reset_app_intg_rdc_4to2, reset_app_intg_rdc_8to4,
                   reset_app_intg_verifier, reset_app_intg_writer, reset_sigs,
                   reset_dram_helper_app, reset_pcie_helper_app,
                   reset_pcie_data_splitter_app);

  ST_Queue<APP_Match> app_intg_mat_rdc_input(64);
  ST_Queue<APP_Ver_Param> app_intg_verifier_input_param(64);
  ST_Queue<APP_Ver_Record> app_intg_verifier_input_record(64);
  ST_Queue<APP_Reduce_Record32> app_intg_rdc_input_32to16(64);
  ST_Queue<APP_Reduce_Record16> app_intg_rdc_input_16to8(64);
  ST_Queue<APP_Reduce_Record8> app_intg_rdc_input_8to4(64);
  ST_Queue<APP_Reduce_Record4> app_intg_rdc_input_4to2(64);
  ST_Queue<APP_Reduce_Record2> app_intg_writer_input_record(64);
  ST_Queue<unsigned int> app_intg_writer_input_param(64);

  ;
  ;
  ;

  ;
  ;
  ;
  ;
  ;
  app_intg_matcher(reset_app_intg_matcher, app_input_params, app_input_data,
                   app_intg_writer_input_param, app_intg_verifier_input_param,
                   app_intg_mat_rdc_input);
  app_intg_mat_rdc(reset_app_intg_mat_rdc, app_intg_mat_rdc_input,
                   app_intg_verifier_input_record);
  app_intg_verifier(reset_app_intg_verifier, app_intg_verifier_input_param,
                    app_intg_verifier_input_record, app_intg_rdc_input_32to16);
  app_intg_rdc_32to16(reset_app_intg_rdc_32to16, app_intg_rdc_input_32to16,
                      app_intg_rdc_input_16to8);
  app_intg_rdc_16to8(reset_app_intg_rdc_16to8, app_intg_rdc_input_16to8,
                     app_intg_rdc_input_8to4);
  app_intg_rdc_8to4(reset_app_intg_rdc_8to4, app_intg_rdc_input_8to4,
                    app_intg_rdc_input_4to2);
  app_intg_rdc_4to2(reset_app_intg_rdc_4to2, app_intg_rdc_input_4to2,
                    app_intg_writer_input_record);
  app_intg_writer(reset_app_intg_writer, app_intg_writer_input_param,
                  app_intg_writer_input_record, app_output_data);
}
