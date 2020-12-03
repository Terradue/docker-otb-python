import click
import otbApplication

@click.command()
@click.option('--red-product', 'red_asset')
@click.option('--nir-product', 'nir_asset')
def main(red_asset, nir_asset):
    
    app = otbApplication.Registry.CreateApplication("BandMathX")

    app.SetParameterStringList("il", [nir_asset, 
                                      red_asset])
    
    app.SetParameterString("out", "ndvi.tif")
    app.SetParameterString("exp", "(im1b1 - im2b1) / (im1b1 + im2b1)")

    app.ExecuteAndWriteOutput()
    
    