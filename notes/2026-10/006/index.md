---
date: '2026-10-13T20:32:24+08:00'
draft: false
title: "让 AI 操作 PowerPoint 去生成 PPT 不 AI 原生"
note_tags: ["Technology", "Agent"]
source: ["https://mp.weixin.qq.com/s/WwonmUsDtTLAkNu2GcfNMA"]
---

用 AI 操作 PowerPoint 去做 PPT 的思路本身不 AI Native，不是说不能操作 PowerPoint，而是做出来不好看，因为目前的 AI 没办法通过“操作”的方式去做出好看的 PPT，它擅长的还是生成。

像 Kimi 那样发明一种 YAML 的中间格式 PPTD (PPT-DSL)，可行，但还不够好。有两个问题：

1. 这种格式没有足够的训练，需要大量的额外说明，所以 Kimi 用了将近 2000 行文档来说明什么是 PPTD，另外这种 YAML 格式本身表达力有限，难以表达完整的格式
2. 不够美观，现在模型设计能力越来越好，但是对于非标准格式效果要大打折扣，模型做设计最熟悉的是 HTML 格式。

也有人说，用模板是不是就可以解决美观的问题。

用模板部分解决了美观问题，但问题是选择会很有限，反而是限制了模型的想象力。

不要忘记《苦涩的教训》：

> 长期来看，依靠大规模算力和通用学习方法的“笨办法”，终将战胜依赖人类专家知识的“聪明捷径”。

换句话说，与其内置一堆模板，不如让模型自己发挥。

目前 AI 做 PPT 的最佳实践应该是 Claude Design 采用的模式：

- 用 Design System 定义好设计风格
- 使用 HTML 生成网页 PPT
- 将 HTML 导出成可编辑的 PPTX（PPTX 是标准格式）

HTML 可以保证大模型生成 PPT 的美观，可以人工二次编辑，又可以几乎无损（不是绝对）转成 PPTX。

这也是我学到的两条经验：

1. 让 Agent 操作它最擅长的格式
2. 给 Agent 规范，而不是模板（不是说不能用模板，而是不能过于依赖模板）
