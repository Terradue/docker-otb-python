$graph:

- baseCommand: docker 

  class: CommandLineTool
  id: docker-builder  

  inputs:
    context:
       type: Directory
    dockerfile:
       type: File
  arguments:    
  - build
  - prefix: -t
    valueFrom: 'otb-norm-diff:0.2'
  - prefix: -f
    valueFrom: $(inputs.dockerfile) 
  - valueFrom: $(inputs.context.path)

  outputs:
    nothing:
      outputBinding:
        glob: .
      type: Directory
      
  requirements:
    InlineJavascriptRequirement: {}

- baseCommand: normalized-difference
  hints:
    DockerRequirement:
      dockerPull: otb-norm-diff:0.2
  class: CommandLineTool
  id: clt
  inputs:
    inp1:
      inputBinding:
        position: 1
        prefix: --nir-product
      type: string
    inp2:
      inputBinding:
        position: 1
        prefix: --red-product
      type: string
  outputs:
    results:
      outputBinding:
        glob: .
      type: Directory
  requirements:
    EnvVarRequirement:
      envDef:
        PATH: /opt/anaconda/envs/env_otb/bin:/opt/anaconda/bin:/usr/share/java/maven/bin:/opt/anaconda/bin:/opt/anaconda/envs/notebook/bin:/opt/anaconda/bin:/usr/share/java/maven/bin:/opt/anaconda/bin:/opt/anaconda/condabin:/opt/anaconda/bin:/usr/lib64/qt-3.3/bin:/usr/share/java/maven/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin
        PREFIX: /opt/anaconda/envs/env_otb
        LD_LIBRARY_PATH: /opt/anaconda/envs/env_otb/lib/:/usr/lib64
        PROJ_LIB: /opt/anaconda/envs/env_otb/conda-otb/share/proj
        GDAL_DATA: /opt/anaconda/envs/env_otb/conda-otb/share/gdal
    ResourceRequirement: {}
#  stderr: std.err
  stdout: std.out
- class: Workflow
  doc: Normalized difference
  id: main
  inputs:
    nir-product:
      doc: NIR asset 
      label: NIR asset 
      type: string
    red-product:
      doc: Red asset 
      label: Red asset 
      type: string
    context:
      type: Directory
    dockerfile:
      type: File
  label: Normalized difference
  outputs:
  - id: wf_outputs
    outputSource:
    - node_1/results
    type: Directory
  requirements:
  - class: SubworkflowFeatureRequirement
  steps:
    node_0:
      in:
        context: context
        dockerfile: dockerfile
      out:
      - nothing
      run: '#docker-builder'

    node_1:
      in:
        inp1: nir-product
        inp2: red-product
        inp3: node_0/nothing
      out:
      - results
      run: '#clt'
cwlVersion: v1.0

