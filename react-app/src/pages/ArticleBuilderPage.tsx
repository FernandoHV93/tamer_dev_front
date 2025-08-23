import React from "react"
import {
  ResizableHandle,
  ResizablePanel,
  ResizablePanelGroup,
} from "../components/ui/resizable"
import StructureSection from "../components/articleBuilder/StructureSection"
import SEOSection from "../components/articleBuilder/SEOSection"
import MediaHubSection from "../components/articleBuilder/MediaHubSection"
import SettingsSection from "../components/articleBuilder/SettingsSection"
import DistributionSection from "../components/articleBuilder/DistributionSection"
import ArticleGeneratorSection from "../components/articleBuilder/GeneratorSection"

function Example() {
  return (
    <ResizablePanelGroup direction="vertical">
      <ResizablePanel>One</ResizablePanel>
      <ResizableHandle />
      <ResizablePanel>Two</ResizablePanel>
    </ResizablePanelGroup>
  )
}

export default function ArticleBuilderPage() {
  return (
    <section className="flex flex-col items-center w-full min-h-[100vh] ">
      <article className="w-auto sm:w-[80%] lg:w-[62%] mb-8 mt-8 max-w-[1200px]">
        <ArticleGeneratorSection/>
      </article>
      <article className="w-auto sm:w-[80%] lg:w-[62%] mb-8 max-w-[1200px]">
        <SettingsSection/>
      </article>
      <article className="w-auto sm:w-[80%] lg:w-[62%] mb-8 max-w-[1200px]">
        <MediaHubSection/>
      </article>
      <article className="w-auto sm:w-[80%] lg:w-[62%] mb-8 max-w-[1200px]">
        <SEOSection/>
      </article>
      <article className="w-auto sm:w-[80%] lg:w-[62%] mb-8 max-w-[1200px]">
        <StructureSection/>
      </article>
      <article className="w-auto sm:w-[80%] lg:w-[62%] mb-8 max-w-[1200px]">
        <DistributionSection/>
      </article>
    </section>
  )
}
