<script setup lang="ts">
  import { ref } from 'vue'
  import { writeText } from '@tauri-apps/api/clipboard';
  const inputValidated = ref('');
  const uploadFile = (event: Event) => {
    const input = event.target as HTMLInputElement;
    const fileList = input.files;
    if (fileList === null || fileList.length === 0) return;
    const file = fileList[0];
    console.log(file);
    const reader = new FileReader();
    reader.onload = async (onLoadEvent: ProgressEvent<FileReader>) => {
      const currentReader = onLoadEvent.target
      if (currentReader === null) return;
      const result = currentReader.result;
      if (typeof result !== 'string') return;
      await writeText(result);
      inputValidated.value = result;
    }
    reader.readAsDataURL(file);
  }
</script>

<template>
  <input type="file" @change="uploadFile">
  <textarea v-model="inputValidated"></textarea>
  <img v-if="inputValidated !== ''" :src="inputValidated" alt="">
</template>

