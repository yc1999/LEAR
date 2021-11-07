export CUDA_VISIBLE_DEVICES=1

DATA_DIR=/data/yangpan/workspace/dataset/ner
SVAE_DIR=/data/yangpan/workspace/nlp_with_label/checkpoint
PRETRAIN_MODEL=bert-base-uncased
RESULT_DIR=/data/yangpan/workspace/nlp_with_label/results
PRETRAIN_MODEL_DIR=/data/yangpan/workspace/pretrain_models/pytorch
DATA_NAME=ace2005
MODEL_TYPE=bert_ner_matrix_with_label_siamese
SAVE_NAME=ner/${DATA_NAME}/${PRETRAIN_MODEL}_${MODEL_TYPE}_attn_testspeed

python ../../run_ner.py \
  --use_cuda true \
  --do_train true \
  --do_eval false \
  --do_lower_case true \
  --model_name ${MODEL_TYPE} \
  --evaluate_during_training true \
  --overwrite_output_dir true \
  --overwrite_cache false \
  --dump_result false \
  --eval_test true \
  --test_speed true \
  --weight_span_loss 1 \
  --use_attn true \
  --task_type ner \
  --span_decode_strategy 'v2' \
  --num_train_epochs 6 \
  --gradient_accumulation_steps 8 \
  --per_gpu_train_batch_size 4 \
  --per_gpu_eval_batch_size 4 \
  --max_seq_length 128 \
  --learning_rate 1e-5 \
  --task_layer_lr 10 \
  --task_save_name ${SAVE_NAME} \
  --model_name_or_path ${PRETRAIN_MODEL} \
  --eval_per_epoch 100 \
  --val_skip_step 1 \
  --output_dir ${SVAE_DIR}/${SAVE_NAME} \
  --result_dir ${RESULT_DIR}/${DATA_NAME} \
  --data_name ${DATA_NAME} \
  --train_set ${DATA_DIR}/${DATA_NAME}/processed/train.json \
  --dev_set ${DATA_DIR}/${DATA_NAME}/processed/dev.json \
  --test_set ${DATA_DIR}/${DATA_NAME}/processed/test.json \
  --vocab_file ${PRETRAIN_MODEL_DIR}/${PRETRAIN_MODEL}/vocab.txt \
  --label_str_file ${DATA_DIR}/${DATA_NAME}/processed/label_annotation.txt \
  --first_label_file ${DATA_DIR}/${DATA_NAME}/processed/label_map.json \
  --data_dir ${DATA_DIR}/cached \
  --warmup_proportion 0.0 \
  --dropout_rate 0.1 \
  --seed 42